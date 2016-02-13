class SecureNotesController < ApplicationController
  before_action :find_wallet
  before_action :build_resource, only: [:new, :create]
  before_action :find_resource, only: [:edit, :update, :destroy]
  before_action :authorize_user

  def new
  end

  def create
    if @secure_note.save
      redirect_to wallet_path(@wallet)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @secure_note.update_attributes(permitted_params)
      redirect_to wallet_path(@wallet)
    else
      render :edit
    end
  end

  def destroy
    @secure_note.destroy

    redirect_to :back
  end

  protected

  def authorize_user
    authorizee @wallet, :manage_secure_notes?
  end

  def find_wallet
    @wallet ||= current_user.wallets.find(params[:wallet_id])
  end

  def build_resource
    @secure_note ||= @wallet.secure_notes.new(permitted_params)
  end

  def find_resource
    @secure_note ||= @wallet.secure_notes.find(params[:id])
  end

  def resource_class
    SecureNote
  end

  def permitted_params
    params.fetch(:secure_note, {}).permit(:name, :note)
  end

  def resource
    @secure_note
  end

  helper_method :resource_class, :resource
end