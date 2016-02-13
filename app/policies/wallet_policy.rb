class WalletPolicy < ApplicationPolicy
  def manage?
    owner?
  end

  def invite?
    owner? || admin?
  end

  def manage_secure_notes?
    owner? || admin?
  end

  protected

  def owner?
    member.try(:owner?)
  end

  def admin?
    member.try(:admin?)
  end

  def member
    user.member_for(record)
  end
end