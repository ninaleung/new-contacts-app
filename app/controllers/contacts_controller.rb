class ContactsController < ApplicationController

  def index

    if user_signed_in?
      @contacts = current_user.contacts.all
    else
      redirect_to "/users/sign_in/"
    end

    

    search_term = params[:search]
    if search_term
      # @contacts = Contact.where("first_name LIKE ? OR last_name LIKE ?", "%#{search_term}, %#{search_term}%" )
      @contacts = Contact.where("first_name LIKE ? OR last_name LIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
    if params[:group]
      @contacts = Group.find_by(name: params[:group]).contacts
    end
  end

  def new
    if user_signed_in?
      render :new
    else
      redirect_to "/users/sign_in/"
    end
  end

  def create
    Contact.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email],
      user_id: params[:user_id]
      )
    flash[:success] = "Contact successfully created!"
    redirect_to '/contacts'
  end

  def show
    @contact = Contact.find_by(id: params[:id])

    if user_signed_in?
      @contact
    else
      redirect_to "/users/sign_in/"
    end

  end

  def edit
    @contact = Contact.find_by(id: params[:id])
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email]
      )
    flash[:success] = "Contact successfully updated!"
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    flash[:success] = "Contact successfully deleted!"
    redirect_to "/contacts/"
  end
end
