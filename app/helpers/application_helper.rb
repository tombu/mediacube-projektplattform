module ApplicationHelper
	def fdate date, includeTime = false
    distance = ((Time.now.to_time - date.to_time).abs).round
    if (!includeTime) 
      date.strftime("%d. %B %Y")
    else
      if distance >= 259200 # 3 days
        date.strftime("%d. %B %Y, %H:%M Uhr")
      elsif distance >= 86400 # 1 day
        "vor #{(distance/86400).round} Tagen"
      elsif distance >= 3600 # 1 hour
        "vor #{(distance/3600).round} Stunden"
      elsif distance >= 60 # 1 minute
        "vor #{(distance/60).round} Minuten"
      elsif distance >= 10 # 10 seconds
        "vor #{distance} Sekunden"
      else "gerade eben"
      end
    end
      
    
  end
  
  def avatar_url user, size
#    if user.avatar_url.present?
#      user.avatar_url
#    else
      default_url = "http://artistandarchitects.at/default_user.jpg" #{root_url}images
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.jpg?s=#{size}&d=#{CGI.escape(default_url)}"
#    end
  end
  
  
  def strim str, length
    truncate str, :length => length+1, :omission => "…"
  end

end
