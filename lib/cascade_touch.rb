require 'cascade_touch/tree'
require "cascade_touch/version"

module CascadeTouch
  class << self
    def call(model_name, model_id, schema)
      tree = Tree.new_from_hash(schema)
      updated = {}

      start_model = model_name.constantize.find(model_id)

      tree.children.each do |c|
        c.visit_all do |node|
          if node.parent && updated[node.parent]
            for_update = updated[node.parent]

            if for_update.is_a? Array
              result = for_update.flatten.map do |model|
                update(model.send(node.name), start_model.updated_at)
              end
            else
              result = update(for_update.send(node.name), start_model.updated_at)
            end
          else
            return unless start_model.send(node.name)

            result = update(start_model.send(node.name), start_model.updated_at)
          end

          updated[node.name] = result
        end
      end
    end

    private

    def update(model, date)
      if model.is_a? ActiveRecord::Base
        model.update_column(:updated_at, date)
      else
        model.update_all(updated_at: date)
        model = model.to_a
      end
      model
    end
  end
end
