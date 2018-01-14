class ContactMailer < ActionMailer::Base
    default to: 'stevenlam5796@gmail.com'
    
    def contact_email(name, email, body)
       @name = name
       @email = email
       @body = body
       mail(from: email, subject: 'Pied Piper contact form message')
    end
end