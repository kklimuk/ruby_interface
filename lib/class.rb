class Class
  class << self
    alias_method :old_new, :new

    def new(*args, &block)
      klass = old_new *args, &block
      klass.anonymous_class_defined if block_given? && klass.respond_to?(:anonymous_class_defined)
      klass
    end
  end
end