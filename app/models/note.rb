class Note < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  belongs_to :user

  scope :active,    -> { where(is_active: true) }
  scope :pending,   -> { where(is_active: false) }

  def owned_by?(user_to_verify)
    user == user_to_verify
  end

  def active?
    is_active
  end

  def approve
    self.is_active = true
    self.save
  end
end
