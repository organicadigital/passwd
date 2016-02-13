class SecureNote < ActiveRecord::Base
  attr_accessor :note
  attr_encrypted :note, key: '123', mode: :per_attribute_iv_and_salt

  belongs_to :wallet

  validates :name, :note, presence: true
end