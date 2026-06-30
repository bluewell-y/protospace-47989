class Prototype < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, :catch_copy, :concept, :image, presence: true
end
