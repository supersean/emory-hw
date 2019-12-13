class Book < ApplicationRecord
  validates :title, :author, presence: true
  belongs_to :author
end
