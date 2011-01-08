module ApplicationHelper
	def fdate date
    date.strftime("%d. %B %Y")
  end
  
  def avatar_url user, size
#    if user.avatar_url.present?
#      user.avatar_url
#    else
      default_url = "http://artistandarchitects.at/default_user.jpg" #{root_url}images
      gravatar_id = Digest::MD5.hexdigest(user.mail.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.jpg?s=#{size}&d=#{CGI.escape(default_url)}"
#    end
  end
  
  def strim str, length
    truncate str, :length => length+1, :omission => "…"
  end
end
