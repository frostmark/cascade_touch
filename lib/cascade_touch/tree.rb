module CascadeTouch
  Tree = Struct.new(:name, :parent, :children) do
    class << self
      def new_from_hash(hash, parent: nil)
        name, children_hash = hash.first
        children = children_hash.map do |k, v|
          Tree.new_from_hash({ k => v }, parent: name)
        end

        Tree.new(name, parent, children)
      end
    end

    def visit_all(&block)
      yield(self)
      children.each { |c| c.visit_all(&block) }
    end
  end
end