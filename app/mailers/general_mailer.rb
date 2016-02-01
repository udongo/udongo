class GeneralMailer < ActionMailer::Base
  def email(email)
    from = "#{email.from_name} <#{email.from_email}>"
    to = "#{email.to_name} <#{email.to_email}>"

    mail(from: from, to: to, subject: email.subject) do |format|
      format.text { render text: email.plain_content }
      format.html { render html: email.html_content.html_safe }
    end

    email.mark_as_sent!
  end
end
