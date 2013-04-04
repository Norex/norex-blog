class Tumble < ActiveRecord::Base
  attr_accessible :content, :content_type, :date, :title, :tumblr_id, :url, :tag_list

  belongs_to :user

  acts_as_taggable

  def self.fetch_new
    client = Tumblr::Client.new do |config|
      config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
      config.consumer_secret =  ENV['TUMBLR_CONSUMER_SECRET']
      config.oauth_token = ENV['TUMBLR_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TUMBLR_OAUTH_TOKEN_SECRET']
    end

    since = Tumble.order("tumblr_id DESC").select("tumblr_id").first
    if since
      posts = client.dashboard(since_id: since.tumblr_id.to_s)
    else
      posts = client.dashboard
    end

    posts['response']['posts'].each do |p|
      title = ''
      content = ''
      link = ''
      skip = false
      case p.type
      when 'text'
        title = p.title
        content = p.body
      when 'quote'
        title = p.source
        content = p.text
      when 'link'
        title = p.title
        content = p.description
        url = p.url
      when 'video'
        title = p.caption
        content = p.player.last.embed_code
      when 'audio'
        title = p.caption
        content = p.player
      when 'photo'
        title = p.caption
        content = p.photos.to_yaml
      when 'chat'
        title = p.title
        content = p.body
      else
        skip = true
      end

      unless skip
        user_name = p.blog_name
        #user = User.where(name: p.blog_name).first
        user = User.where(name: user_name).first_or_create

        # Issues here for whatever reason.
        blog_info = client.blog_info(user_name + '.tumblr.com')['response']['blog']
        avatar = client.avatar(user_name + '.tumblr.com', size: 64)['response']
        #if user
        user.update_attributes(blog_name: blog_info.title, photo: avatar.avatar_url, description: blog_info.description)
        # else
        #   user = User.create(name: user_name, blog_name: blog_info.title, photo: avatar.avatar_url, description: blog_info.description)
        # end
        # if user
        #   user.update_attributes(blog_name: 'Blog Name', photo: '', description: 'Description')
        # else
        #   user = TumblrUser.create(name: user_name, blog_name: 'Blog Name', photo: '', description: 'Description')
        # end

        new_tumble = user.tumbles.create(content: content, content_type: p.type, date: p.date, title: title, tumblr_id: p.id, url: url)

        # new_tumble = Tumble.create(tumble_id: p.id, content_type: p.type, title: title, url: url)
        # new_tumble.create_post(content: content , date: p.date, user_name: p.blog_name)

        #:content, :content_type, :date, :title, :tumblr_id, :url, :tag_list

        new_tumble.tag_list = p.tags
        new_tumble.save
        # p.tags.each do |tag|
        #   new_tumble.tumblr_tags << TumblrTag.create(name: tag)# << TumblrTag.create(name: tag)
        #   new_tumble.save
        # end
        
        #user.tumbles << new_tumble
        #user.save
      end
    end
  end
end
