module Udongo::EmailVarsParser
  def replace_vars(content, vars, conditionals_allowed = true)
    vars.each do |key, value|
      content = content.gsub(Regexp.new('\[' + key.to_s + '\]'), value.to_s)
    end

    conditionals_allowed ? replace_ifs(content, vars) : content
  end

  def replace_ifs(content, vars)
    content.to_s.scan(/\[if\:([a-z\._\-]+)\](.*?)\[\/if\]/mi).each do |match|
      if_var = match.first
      if_content = match.last

      if vars[if_var] || vars[if_var.to_sym]
        content = content.gsub("[if:#{if_var}]#{if_content}[/if]", if_content)
      else
        content = content.gsub("[if:#{if_var}]#{if_content}[/if]", '')
      end
    end

    content
  end
end

