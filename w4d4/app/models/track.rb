class Track < ActiveRecord::Base
  validates :title, :album_id, :track_type, presence: true
  validates :track_type, inclusion: { in: ["bonus", "regular"] }

  belongs_to :album

  has_one :band,
    through: :album,
    source: :band

  has_many :notes
end
