module ApplicationHelper
  def in_action(action)
    params[:action].downcase == action.to_s.downcase
  end

  def tag_link_to(tag, count)
    current_tags = params[:tags].try(:dup) || nil
    all_tags = Tumble.tag_counts.map { |tag| tag.name }

    if current_tags.nil?
      current_tags = all_tags.reject { |t| t == tag } 
      link_to raw("#{tag} (#{count}) <span class='light'>&nbsp;</span>"), params.merge({:"tags" => current_tags}), class: 'active',  data: { shown: 'true', tag: tag }
    else
      if current_tags.include? tag
        currently_active = true
        current_tags = current_tags.reject { |t| t == tag } 
      else
        current_tags = (current_tags << tag)
      end

      current_tags = current_tags.reject { |t| t == 'none' } 
      link_to raw("#{tag} (#{count}) <span class='light'>&nbsp;</span>"), params.merge({:"tags" => current_tags.any? ? current_tags : ['none']}), class: (currently_active ? 'active' : ''),  data: { shown: 'true', tag: tag }   
    end
  end

  def type_link_to(type, type_plural)
    type = type.to_s
    type_plural = type_plural.to_s
    current_types = params[:types].try(:dup) || nil
    all_types = %w{photo video text misc}

    if current_types.nil?
      current_types = all_types.reject { |t| t == type } 
      link_to raw("<span class='entypo #{type_plural}'>&nbsp;</span>"), params.merge({:"types" => current_types}), class: 'active'
    else
      if current_types.include? type
        currently_active = true
        current_types = current_types.reject { |t| t == type } 
      else
        current_types = (current_types << type)
      end

      current_types = current_types.reject { |t| t == 'none' } 
      link_to raw("<span class='entypo #{type_plural}'>&nbsp;</span>"), params.merge({:"types" => current_types.any? ? current_types : ['none']}), class: (currently_active ? 'active' : '')
    end
  end
end
