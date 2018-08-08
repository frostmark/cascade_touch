module CascadeTouch
  class Updater
    def initialize(model_name, model_id, schema)
      @updated = {}

      @tree = Tree.new_from_hash(schema).children
      @start_model = model_name.constantize.find(model_id)
      @date = @start_model.updated_at
    end

    class << self
      def call(*attrs)
        new(*attrs).call
      end
    end

    def call
      @tree.each do |children|
        children.visit_all do |node|
          if node.parent && @updated[node.parent]
            for_update = @updated[node.parent]

            if for_update.is_a? Array
              result = for_update.flatten.map do |model|
                current_model = model.send(node.name)
                next if current_model.nil?

                update_model_or_collection(current_model)
              end
            else
              update_model_or_collection(for_update.send(node.name))
            end
          else
            current_model = @start_model.send(node.name)
            next if current_model.nil?

            result = update_model_or_collection(current_model)
          end

          @updated[node.name] = result
        end
      end
    end

    private

    def update_model_or_collection(model_or_collection)
      if model_or_collection.is_a? ActiveRecord::Base
        update(model_or_collection)
      else
        update_collection(model_or_collection)
      end
    end

    def update(model)
      model.update_column(:updated_at, @date)
    end

    def update_collection(collection)
      collection.update_all(updated_at: @date)
      collection.to_a
    end
  end
end