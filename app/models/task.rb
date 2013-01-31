class Task < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5, maximum: 200}
  validates :owner, presence: true, length: {maximum: 200}, single_word: true
  validates :tags, length: 0..100
  validates :description, length: {maximum: 500}
  validate :completed_in_present_or_past

  def completed_in_present_or_past
    errors.add(:completed_at, "You cannot complete a task in the future") if !completed_at.nil? && completed_at >= Time.now
  end
end
