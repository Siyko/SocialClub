class Comment < ActiveRecord::Base
  has_many :attachments , as: :entity
  belongs_to :task
  belongs_to :user
  accepts_nested_attributes_for :attachments
end
