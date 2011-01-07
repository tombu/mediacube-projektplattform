module ApplicationHelper
	def fdate date
    date.strftime("%d. %B %Y")

  def avatar_url(user)
#    if user.avatar_url.present?
#      user.avatar_url
#    else
      default_url = "#{root_url}images/default_user.jpg"
      gravatar_id = Digest::MD5.hexdigest(user.mail.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=40&d=#{CGI.escape(default_url)}"
#    end
  end
end
