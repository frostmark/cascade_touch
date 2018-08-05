module CascadeTouch
  class Updater
    def initialize(date)
      @date = date
    end

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