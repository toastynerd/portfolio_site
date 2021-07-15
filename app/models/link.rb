class Link < ApplicationRecord
  validates :body, :icon_url, presence: true
  belongs_to :linkable, polymorphic: true
end
