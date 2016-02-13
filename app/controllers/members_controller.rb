class MembersController < ApplicationController
  before_action :find_wallet
  before_action :build_resource
  before_action :find_resource, only: [:destroy]
  before_action :authorize_invite, only: [:new, :create]

  def new
  end

  def create
    if @invite.save
      redirect_to wallet_path(@wallet)
    else
      render :new
    end
  end

  def destroy
    authorize @member, :destroy?

    @member.destroy

    redirect_to wallet_path(@wallet)
  end

  protected

  def authorize_invite
    authorize @wallet, :invite?
  end

  def find_resource
    @member ||= @wallet.members.find(params[:id])
  end

  def permitted_params
    permitted = params.fetch(:invite, {}).permit(:email, :role)

    permitted.merge(wallet: @wallet, current_user: current_user)
  end

  def build_resource
    @invite = Invite.new(permitted_params)
  end

  def find_wallet
    @wallet ||= current_user.wallets.find(params[:wallet_id])
  end

  def resource_class
    Member
  end

  def resource
    @invite
  end

  helper_method :resource_class, :resource
end