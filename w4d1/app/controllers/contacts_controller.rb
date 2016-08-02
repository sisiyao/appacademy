class ContactsController < ApplicationController
  def index
    @contact = Contact.where(id: params[:user_id])
    render json: @contact
  end

  def show
    @contact = Contact.find_by(id: params[:id])

    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    @contact = Contact.find_by(id: params[:id])

    if @contact.update(contact_params)
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: @contact
  end


  def favorites
    @favorites = Favorite.where(fav_id: params[:user_id], fav_type: "Contact")

    render json: @favorites
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
