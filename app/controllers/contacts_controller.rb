class ContactsController < ApplicationController

# GET request to /contact-us

# Show new contact form 
def new
    @contact = Contact.new
end

# POST request /contacts 
def create
    # Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params)
    # Save Contact object to database
    if @contact.save
        # Store form fields via parameters, into variables.
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:message]
        # Plug variables into Contact Mailer email method & send email
        ContactMailer.contact_email(name, email, body).deliver
        # Store success maessage in a flash has and redirect to new page
        flash[:success] = "Message sent"
        redirect_to new_contact_path
    else
        # If Contact object doesnt save, store errors in flash hash and 
        # redirect to new page path
        flash[:danger] = @contact.errors.full_messages.join(". ")
        redirect_to new_contact_path
    end
end

private
    # To collect data from form, we need to use 'strong' parameters and 
    # whitelist the form fields. (security feature)
    def contact_params
         params.require(:contact).permit(:name, :email, :message)
    end
end
