class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  self.primary_key = :task_id
  has_attached_file :attachment,
                    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    :url => "/system/:attachment/:id/:basename_:style.:extension",
                    :styles => {
                        :thumb    => ['100x100#',  :jpg, :quality => 70],
                        :preview  => ['480x480#',  :jpg, :quality => 70],
                        :large    => ['600>',      :jpg, :quality => 70],
                        :retina   => ['1200>',     :jpg, :quality => 30]
                    }
  validates :task_id, :title, :uniqueness => true
  validates_attachment :attachment,
                       :size => { :in => 0..10.megabytes },
                       :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
  def to_param
    task_id
  end
end
