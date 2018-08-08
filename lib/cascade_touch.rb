require 'cascade_touch/tree'
require 'cascade_touch/updater'
require "cascade_touch/version"

module CascadeTouch
  class << self
    def call(model_name, model_id, schema)
      Updater.call(model_name, model_id, schema)
    end
  end
end
