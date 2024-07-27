class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images
  has_many_attached :videos
  validates :title, :content, :status, presence: true
  validates :status, inclusion: { in: %w(draft published) }
  validates :creation_date, presence: true
  validates :published_date, presence: true, if: -> { status == 'published' }
  validate :published_date_must_be_after_creation_date
  

  private

  def published_date_must_be_after_creation_date
    return unless published_date.present? && creation_date.present?
    errors.add(:published_date, "must be after creation date") if published_date < creation_date
  end
end
