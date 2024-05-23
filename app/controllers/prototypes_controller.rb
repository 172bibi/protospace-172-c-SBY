class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.all
  end
end
