class WalletsController < ApplicationController
  before_action :build_resource, only: [:new, :create]
  before_action :find_resource, only: [:edit, :update, :destroy, :show]

  def index
    @wallets = default_scope.ordered
  end

  def new
  end

  def create
    if @wallet.save
      current_user.wallets << @wallet
      redirect_to collection_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @wallet.update_attributes(permitted_params)
      redirect_to collection_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @wallet.destroy

    redirect_to collection_path
  end

  protected

  def default_scope
    current_user.wallets
  end

  def collection_path
    {action: :index}
  end

  def build_resource
    @wallet ||= Wallet.new(permitted_params)
  end

  def find_resource
    @wallet ||= default_scope.find(params[:id])
  end

  def permitted_params
    params.fetch(:wallet, {}).permit(:name)
  end

  def resource_class
    Wallet
  end

  def resource
    build_resource
  end

  helper_method :resource_class, :resource
end