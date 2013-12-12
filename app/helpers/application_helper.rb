module ApplicationHelper

  # Remove the locale but keep all the other params
  def remove_locale(url)
    target = url.split('?')
    vars = target[1].split('&') rescue []
    vars.delete_if {|var| var.include? 'locale=' }
    if vars.size > 0
      target[0].to_s + '?' + vars.join('&')
    else
      target[0].to_s
    end
  end

  # Add locale to the end of params
  def add_locale(url, locale)
    if url.include?('?')
      url + "&locale=#{locale}"
    else
      url + "?locale=#{locale}"
    end
  end
  
end
