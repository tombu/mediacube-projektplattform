module ApplicationHelper
  def fdate date, includeTime = false, includeFormat = false
    distance = ((Time.now.to_time - date.to_time).abs).round
    options = [[86400,"Tag"],[3600,"Stunde"],[60,"Minute"],[10,"Sekunde"]]
    
    if !includeFormat
      if !includeTime
        date.strftime("%d. %B %Y")
      else
        date.strftime("%d. %B %Y, %H:%M Uhr")
      end
    else
      if distance >= 259200 # 3 days
        date.strftime("%d. %B %Y")
      else
        if distance >= 86400 # 1 day
          selection = 0
        elsif distance >= 3600 # 1 hour
          selection = 1
        elsif distance >= 60 # 1 minute
          selection = 2
        elsif distance >= 10 # 10 seconds
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
    if url
      "http://" + url.to_s
    end
  end
  
  def strim str, length
    truncate str, :length => length+1, :omission => "…"
  end

end
