class Note < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }

  scope :active,    -> { where(is_active: true) }
  scope :pending,   -> { where(is_active: false) }
  scope :by_admin,  -> { joins(:user).where('users.is_admin' => 'true') }

  def owned_by?(user_to_verify)
    user.present? && user == user_to_verify
  end

  # In retrospect, the column should be called active not is_active so this method would not be needed
  def active?
    is_active
  end

  def approve
    self.is_active = true
    self.save
  end
end
