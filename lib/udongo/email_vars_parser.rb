module Udongo::EmailVarsParser
  def replace_vars(content, vars, conditionals_allowed = true, prefix: nil)
    vars.each do |key, value|
      key = "#{prefix}.#{key}" if prefix.present?

      if value.respond_to?(:each)
        content = replace_vars(content, value, prefix: key)
      else
        content.gsub!(Regexp.new('\[' + key.to_s + '\]'), value.to_s)
      end
    end

    conditionals_allowed ? replace_ifs(content, vars) : content
  end

  def replace_ifs(content, vars)
    content.to_s.scan(/\[if\:([a-z\._\-]+)\](.*?)\[\/if\]/mi).each do |match|
      if_var = match.first
      if_content = match.last

      if vars[if_var] || vars[if_var.to_sym]
        content.gsub!("[if:#{if_var}]#{if_content}[/if]", if_content)
      else
        content.gsub!("[if:#{if_var}]#{if_content}[/if]", '')
      end
    end

    content
  end
end

