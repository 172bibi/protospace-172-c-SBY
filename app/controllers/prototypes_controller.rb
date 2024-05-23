class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user)
  end
end
