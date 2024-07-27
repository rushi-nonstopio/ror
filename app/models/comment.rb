class Comment < ApplicationRecord
  belongs_to :post
  validates :name, :text, presence: true
end
