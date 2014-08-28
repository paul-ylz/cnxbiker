class Route < ActiveRecord::Base
  has_one :track, dependent: :destroy
  accepts_nested_attributes_for :track
  validates :title, presence: true
end
