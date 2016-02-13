class User < ActiveRecord::Base
  GRAVATAR = "http://www.gravatar.com/avatar/%{hash}?s=%{size}&d=mm"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :invitable

  validates :email, domain_email: true


  belongs_to :invited_by, polymorphic: true
  has_many :members, dependent: :destroy
  has_many :owner_members, ->{ owner }, class_name: 'Member'
  has_many :wallets, through: :members
  has_many :owner_wallets, through: :owner_members, source: :wallet

  def email_hash
    @email_hash ||= Digest::MD5.hexdigest(email.to_s)
  end

  def avatar(size = 30)
    @avatar ||= sprintf(GRAVATAR, hash: email_hash, size: size)
  end

  def role_for(wallet)
    @roles_for ||= {}
    @roles_for[wallet] ||= members.where(wallet_id: wallet).first.try(:role)
  end
end
