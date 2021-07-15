class Project < ApplicationRecord
  validates :title, :description, presence: true
  has_many :links, as: :linkable
end
