class Book < ApplicationRecord
  validates :title, :author, presence: true
  belongs_to :author

  has_one_attached :cover_image
end
