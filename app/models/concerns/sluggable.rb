require 'active_support/concern'

module Sluggable
  extend ActiveSupport::Concern

  def find_by_slug(slug)
    self.friendly.find(id)
  end

end