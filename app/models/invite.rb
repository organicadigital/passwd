class Invite
  include ActiveModel::Model

  attr_accessor :email, :wallet, :current_user, :role

  validates :email, :wallet, :current_user, :role, presence: true
  validates :email, domain_email: true
  validate :already_member
  validate :allowed_role

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      user = create_user!

      wallet.members.create!(user: user, role: role)
      user.deliver_invitation
    end

    true
  end

  protected

  def create_user!
    User.invite!({email: email, skip_invitation: true}, current_user)
  end

  def allowed_role
    transferable_roles = Member.transferable_roles(current_user.role_for(wallet))

    return if role.blank? || transferable_roles.include?(role.to_s.to_sym)

    errors.add(:role, I18n.t('erros.messages.inclusion'))
  end

  def already_member
    return if wallet.users.where(email: email).empty?

    errors.add(:email, I18n.t('errors.messages.already_member'))
  end
end