class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
     @contact = Contact.new(contact_params)
     
    if @contact.save
      
      # recorded variables to send the email to myself based on template in view/contact_mailer/contact_email.html.erb
      name = params[:contact][:name] #nested hash, name, email, comments are inside contact. Rails names this entire hash 'params'.
      email = params[:contact][:email]
      body = params[:contact][:comments]
      
      # run ContactMailer from contact_mailer.rb
      ContactMailer.contact_email(name, email, body).deliver
      
      # show success message
      flash[:success] = 'Message sent.'
      redirect_to new_contact_path
    else
      flash[:danger] = 'Error occured, message has not been sent.'
      redirect_to new_contact_path
    end
  end
  
   private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end