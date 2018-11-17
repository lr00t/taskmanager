class Task < ApplicationRecord
  include AASM

  belongs_to :user, inverse_of: :tasks

  aasm column: 'state' do
    state :new, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end
  end

  mount_uploader :file, FileUploader

  validates :name, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
