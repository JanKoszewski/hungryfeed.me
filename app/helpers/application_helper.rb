module ApplicationHelper
  def current_user_name_tag(current_user)
    tag('meta', name: 'current-user-name', content: current_user.twitter_username)
  end

  def current_user_link_tag(current_user)
    tag('meta', name: 'current-user-link', content: current_user.twitter_link)
  end

  def current_klout_score_tag(current_user)
    tag('meta', name: 'current-user-klout-score', content: current_user.klout_score)
  end
end