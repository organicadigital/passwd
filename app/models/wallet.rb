class Wallet < ActiveRecord::Base
  validates :name, presence: true

  scope :ordered, -> { order(:name) }

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :secure_notes, dependent: :destroy
end