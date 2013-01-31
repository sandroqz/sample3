class Task < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5, maximum: 200}
  validates :owner, presence: true, length: {maximum: 200}, single_word: true
  validates :tags, length: 0..100
  validates :description, length: {maximum: 500}
  validate :completed_in_present_or_past

  before_validation {|taks| puts "before validation"; true}
  after_validation {|task| puts "after validation"; true}
  before_save {|task| puts "before save"; true}
  after_save :already_saved
  before_create {|task| puts "before create"; true}
  after_create {|task| puts "after create"; true}
  around_create :will_save_in_the_block
  before_update {|task| puts "before update"; true}
  after_update {|task| puts "after update"; true}
  around_update {|task, &block| puts "around update"; block.call}
  before_destroy {|task| puts "before destroy"; true}
  after_destroy {|task| puts "after destroy"; true}
  around_destroy {|task, &block| puts "around destroy"; block.call}

  after_initialize do
    puts "task created!"
  end

  after_find :found_me

  private
  def found_me
    puts "loaded from db: #{id}"
  end

  def completed_in_present_or_past
    errors.add(:completed_at, "You cannot complete a task in the future") if !completed_at.nil? && completed_at >= Time.now
  end

  def already_saved
    puts "after save"
    true
  end

  def will_save_in_the_block
    puts "around create";
    yield
  end
end
