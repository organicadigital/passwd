class SecureNote < ActiveRecord::Base
  belongs_to :wallet

  validates :name, :note, presence: true
end