module ApplicationHelper
  def in_action(action)
    params[:action].downcase == action.to_s.downcase
  end

  def tag_link_to(tag, count)
    current_tags = get_current_tags(tag)
    #params[:action] = 'index'
    
    link_to raw("#{tag} (#{count}) <span class='light'>&nbsp;</span>"), params.merge({:"tags" => current_tags.any? ? current_tags : ['none']}), class: (current_tags.include?(tag) ? '' : 'active')
  end

  def type_link_to(type, type_plural, out)
    type = type.to_s
    current_types = get_current_types(type)
    
    link_to raw("<span class='entypo #{type_plural.to_s}'>&nbsp;</span>"), params.merge({:"types" => current_types.any? ? current_types : ['none']}), class: type_link_to_classes(!current_types.include?(type), out)
  end

  def user_link_to(user)
    user = user.to_s
    current_users = get_current_users(user)
   
    link_to raw("<span class='#{(current_users.include?(user) ? '' : 'on')}'>&nbsp;</span>"), params.merge({:"users" => current_users.any? ? current_users : ['none']}), class: 'switch'
  end

  def type_link_to_classes(active, out)
    classes = []
    classes << 'active' if active
    classes << 'out' if out

    classes.join ' '
  end

  def get_current_tags(tag)
    current_tags = params[:tags].try(:dup) || nil
    all_tags = Tumble.tag_counts.map { |tag| tag.name }

    if current_tags.nil?
      current_tags = all_tags.reject { |t| t == tag } 
    else
      if current_tags.include? tag
        current_tags = current_tags.reject { |t| t == tag } 
      else
        current_tags = (current_tags << tag)
      end

      current_tags = current_tags.reject { |t| t == 'none' } 
    end

    current_tags
  end

  def get_current_types(type)
    type = type.to_s

    current_types = params[:types].try(:dup) || nil
    all_types = %w{photo video text misc}

    if current_types.nil?
      current_types = all_types.reject { |t| t == type } 
    else
      if current_types.include? type
        current_types = current_types.reject { |t| t == type } 
      else
        current_types = (current_types << type)
      end

      current_types = current_types.reject { |t| t == 'none' } 
    end

    current_types
  end

  def get_current_users(user)
    current_users = params[:users].try(:dup) || nil
    all_users = User.all.map { |user| user.id.to_s }

    if current_users.nil?
      current_users = all_users.reject { |u| u == user }
    else
      puts 'NOT IN NIL'
      if current_users.include? user
        current_users = current_users.reject { |u| u == user } 
      else
        current_users = (current_users << user)
      end

      current_users = current_users.reject { |u| u == 'none' } 
    end

    current_users
  end

end
