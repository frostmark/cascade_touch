require 'cascade_touch/tree'
require 'cascade_touch/updater'
require "cascade_touch/version"

module CascadeTouch
  class << self
    def call(model_name, model_id, schema)
      tree = Tree.new_from_hash(schema).children
      updated = {}

      start_model = model_name.constantize.find(model_id)
      updater = Updater.new(start_model.updated_at)

      tree.each do |children|
        children.visit_all do |node|
          if node.parent && updated[node.parent]
            for_update = updated[node.parent]

            if for_update.is_a? Array
              result = for_update.flatten.map do |model|
                current_model = model.send(node.name)
                next if current_model.nil?

                updater.update_model_or_collection(current_model)
              end
            else
              updater.update_model_or_collection(for_update.send(node.name))
            end
          else
            current_model = start_model.send(node.name)
            next if current_model.nil?

            result = updater.update_model_or_collection(current_model)
          end

          updated[node.name] = result
        end
      end
    end
  end
end
