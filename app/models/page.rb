class Page < ActiveRecord::Base
  extend FriendlyId
  include Sluggable

  friendly_id :title, use: [:slugged, :history]

end