class Task < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, as: :entity
  has_many :comments
  accepts_nested_attributes_for :attachments


  validates :task_id, :title, :uniqueness => true

  def to_param
    task_id
  end
end
