module ApplicationHelper
  def formatDate date, includeTime = false, includeFormat = false
    distance = ((Time.now.to_time - date.to_time).abs).round
    options = [[1.day,"Tag"],[1.hour,"Stunde"],[1.minute,"Minute"],[1.second,"Sekunde"]]
    
    if !includeFormat
      if !includeTime
        date.strftime("%d. %B %Y")
      else date.strftime("%d. %B %Y, %H:%M Uhr")
    end
    else
      if distance >= 3.day # 3 days
        date.strftime("%d. %B %Y")
      else
        if distance >= 1.day # 1 day
          selection = 0
        elsif distance >= 1.hour # 1 hour
          selection = 1
        elsif distance >= 1.minute # 1 minute
          selection = 2
        elsif distance >= 10.second # 10 seconds
          selection = 3
        else 
          return "gerade eben"
        end
        
        count = (distance/options[selection][0]).round
        "vor #{pluralize count, options[selection][1]}"
      end
    end 
  end
  
  def avatar_url user, size
    default_url = (size<=40) ? "http://artistandarchitects.at/default_user_small.jpg" : "http://artistandarchitects.at/default_user.jpg"
    
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.jpg?s=#{size}&d=#{CGI.escape(default_url)}"
  end
  
  def external_url url
    if url && url[0..6] != "http://"
      "http://" + url.to_s
    else
      url.to_s
    end
  end
  
  def trimString str, length
    truncate str, :length => length+1, :omission => "…"
  end

end
