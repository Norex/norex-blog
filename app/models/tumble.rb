class Tumble < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :content, :content_type, :date, :title, :tumblr_id, :url, :tag_list

  belongs_to :user

  acts_as_taggable
  friendly_id :title, use: :slugged

  def self.get_by_tags(params)
    tags = params[:tags] || nil

    if tags.nil?
      order('date DESC')
    else
      tagged_with(tags, any: true).order('date DESC')
    end
  end

  def self.fetch_new
    client = Tumblr::Client.new do |config|
      config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
      config.consumer_secret =  ENV['TUMBLR_CONSUMER_SECRET']
      config.oauth_token = ENV['TUMBLR_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TUMBLR_OAUTH_TOKEN_SECRET']
    end

    posts = get_posts_from_tumblr(client)
    
    posts['response']['posts'].each do |post|
      attributes = get_attributes(post)

      if attributes
        user_name = post.blog_name
        user = User.where(name: user_name).first_or_create

        blog_info = client.blog_info(user_name + '.tumblr.com')['response']['blog']
        avatar = client.avatar(user_name + '.tumblr.com', size: 64)['response']
       
        user.update_attributes(blog_name: blog_info.title, photo: avatar.avatar_url, description: blog_info.description)
        new_tumble = user.tumbles.create(attributes.merge(content_type: post.type, date: post.date, tumblr_id: post.id))
        new_tumble.tag_list = post.tags
        new_tumble.save
      end
    end
  end

  def self.get_posts_from_tumblr(client)
    since = Tumble.order("tumblr_id DESC").select("tumblr_id").first
    posts = since ? client.dashboard(since_id: since.tumblr_id.to_s) : client.dashboard
  end

  def self.get_attributes(tumble)
    attributes = { title: '', content: '', url: ''}

    case tumble.type
    when 'text', 'chat'
      attributes.merge!({ title: Sanitize.clean(tumble.title), content: tumble.body })
    when 'quote'
      attributes.merge!({ title: Sanitize.clean(tumble.source), content: tumble.text })
    when 'link'
      attributes.merge!({ title: Sanitize.clean(tumble.title), content: tumble.description, url: tumble.url })
    when 'video'
      attributes.merge!({ title: Sanitize.clean(tumble.caption), content: tumble.player.last.embed_code })
    when 'audio'
      attributes.merge!({ title: Sanitize.clean(tumble.caption), content: tumble.player })
    when 'photo'
      attributes.merge!({ title: Sanitize.clean(tumble.caption), content: tumble.photos.to_yaml })
    else
      attributes = nil
    end

    attributes
  end
end
