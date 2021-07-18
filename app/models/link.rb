class Link < ApplicationRecord
  validates :url, :description, :icon_url, presence: true
  belongs_to :linkable, polymorphic: true
end
