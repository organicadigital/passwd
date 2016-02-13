class Invite
  include ActiveModel::Model

  attr_accessor :email, :wallet, :current_user

  validates :email, :wallet, :current_user, presence: true
  validates :email, domain_email: true
  validate :already_member

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      user = create_user!

      wallet.users << user
      user.deliver_invitation
    end

    true
  end

  protected

  def create_user!
    User.invite!({email: email, skip_invitation: true}, current_user)
  end

  def already_member
    return if wallet.users.where(email: email).empty?

    errors.add(:email, I18n.t('errors.messages.already_member'))
  end
end