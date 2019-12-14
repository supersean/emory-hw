class Author < ApplicationRecord
  validates :name, :email, presence: true
  validates :name, :email, length: { maximum: 50 }
  
  has_many :books

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
