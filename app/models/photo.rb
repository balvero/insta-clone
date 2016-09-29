class Photo < ApplicationRecord
  acts_as_votable
  belongs_to :user
  validates_presence_of :image
  validates :title, presence: true, length: { minimum: 3, maximum: 120 }
  validates :description, presence: true, length: { minimum: 3 }

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
