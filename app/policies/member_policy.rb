class MemberPolicy < ApplicationPolicy
  def destroy?
    (owner? || admin?) && user != record.user
  end

  protected

  def owner?
    member.try(:owner?)
  end

  def admin?
    member.try(:admin?)
  end

  def member
    user.member_for(record.wallet)
  end
end