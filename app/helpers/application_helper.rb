module ApplicationHelper
  def in_action(action)
    params[:action].downcase == action.to_s.downcase
  end

  def tags_link_for_link(tag)
    current_tags = params[:tags].dup || nil
    all_tags = Tumble.tag_counts.map { |tag| tag.name }

    if current_tags.nil?
      link_to tag, params.merge({:"tags" => all_tags})#, class: (params['tags'].try(:include?, tumblr_tag.id.to_s) ? "active" : ""),  data: { shown: 'true', tag: tumblr_tag.id }
    else
      require 'pp'
      puts 'yaaaa'
      puts tag
      pp current_tags

      if current_tags.include? tag
        current_tags = current_tags.reject { |t| t == tag } 
      else
        current_tags = (current_tags << tag)
      end
      
      # puts 'waaaa'
      # pp current_tags
      # current_tags = (current_tags << tag)
      # # puts current_tags
      # current_tags.delete(tag)
      # # puts current_tags.class
      # require 'pp'
      # pp params
      # pp current_tags
      # puts 'yaaa'



      link_to tag, params.merge({:"tags" => current_tags})#, class: (params['tags'].try(:include?, tumblr_tag.id.to_s) ? "active" : ""),  data: { shown: 'true', tag: tumblr_tag.id }   
    end
    #link_to tag, params.merge({:"tags[]" => tumblr_tag.id}), class: (params['tags'].try(:include?, tumblr_tag.id.to_s) ? "active" : ""),  data: { shown: 'true', tag: tumblr_tag.id }
  end
end
