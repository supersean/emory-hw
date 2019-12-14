class Book < ApplicationRecord
  validates :title, :author, presence: true
  belongs_to :author

  has_one_attached :cover_image

  def editable_by? editing_author
    editing_author.id == author.id
  end

end
