class User < ActiveRecord::Base
  ALLOWED_DOMAIN = Rails.application.secrets.allowed_user_domain

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :email, format: {with: /@#{ALLOWED_DOMAIN}\z/,
                             message: I18n.t('errors.messages.invalid_domain',
                                             domain: ALLOWED_DOMAIN)}
end
