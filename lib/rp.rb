require "rp/engine"

module Rp
  mattr_accessor :root_url

  # this function maps the vars from your app into your engine
  def self.setup(&block)
     yield self
  end
end
