module ApplicationHelper
  def in_action(action)
    params[:action].downcase == action.to_s.downcase
  end
end
