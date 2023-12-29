module ControllerHelpers
  extend ActiveSupport::Concern

  included do
    routes { Rp::Engine.routes }
  end
end
