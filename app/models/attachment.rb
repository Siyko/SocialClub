class Attachment < ActiveRecord::Base
  has_attached_file :attachment,
                    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    :url => "/system/:attachment/:id/:basename_:style.:extension"


  validates_attachment_content_type :attachment,  :content_type => ["image/jpeg","image/png"]
  validates_attachment_size :attachment,    :in => 0..100.megabytes


end
