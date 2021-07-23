class StaticController < ApplicationController
  def home
    @links = User.first.links
  end

  def projects
  end
end
