class Member < ActiveRecord::Base
  enum role: {owner: 'owner', admin: 'admin', reader: 'reader'}

  class << self
    def transferable_roles(role)
      return roles.keys if roles[:owner] == role
      return [:admin, :reader] if roles[:admin] == role

      []
    end
  end

  belongs_to :user
  belongs_to :wallet
end