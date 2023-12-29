require 'pundit'

module Rp
  mattr_accessor :editor_role do
    :editor
  end

  class Engine < ::Rails::Engine
    isolate_namespace Rp
        
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.template_engine :haml
      g.assets false
      g.helper false
    end
    
    initializer :append_migrations do |app|
      unless app.root.to_s.match "#{root}/"
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
