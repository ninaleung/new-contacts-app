class ContactsController < ApplicationController
  def index
    @contacts = Contact.all

    search_term = params[:search]
    if search_term
      # @contacts = Contact.where("first_name LIKE ? OR last_name LIKE ?", "%#{search_term}, %#{search_term}%" )
      @contacts = Contact.where("first_name LIKE ? OR last_name LIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
  end

  def new
  end

  def create
    Contact.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email]
      )
    flash[:success] = "Contact successfully created!"
    redirect_to '/contacts'
  end

  def show
    @contact = Contact.find_by(id: params[:id])
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
