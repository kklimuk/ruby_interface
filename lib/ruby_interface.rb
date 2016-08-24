require 'ruby_interface/version'
require 'class'
require 'awesome_print'

module RubyInterface
  def self.included(klass)
    klass.extend ClassMethods

    klass.class_eval do
      singleton_class.send(:alias_method, :_old_inherited, :inherited) if respond_to?(:inherited)
    end

    def klass.inherited(child)
      child.name.nil? ? anonymous_class_definition(child) : named_class_definition(child)
      _old_inherited(child) if respond_to?(:_old_inherited)
    end
  end

  module ClassMethods
    def defines(*args)
      @methods_to_define ||= []
      @methods_to_define += args
    end

    def track_required_methods(child)
      missing_methods = @methods_to_define - child.instance_methods(false)

      return if missing_methods.empty?

      message = "Expected #{child.name || 'anonymous class'} to define "
      message << missing_methods.map { |method| "##{method}" }.join(', ')
      raise NotImplementedError, message
    end

    private

    def anonymous_class_definition(child)
      define_class_hook child
      redefine_eval_and_exec child
    end

    def define_class_hook(child)
      klass = self
      child.define_singleton_method :anonymous_class_defined do
        klass.track_required_methods(child)
        revert_eval_and_exec
      end
    end

    def redefine_eval_and_exec(child)
      klass = self

      [:class_exec, :class_eval].each do |method|
        old_method = "_old_#{method}".to_sym
        child.singleton_class.send(:alias_method, old_method, method)

        child.define_singleton_method method do |*args, &block|
          send old_method, *args, &block
          klass.track_required_methods(child)
          revert_eval_and_exec
        end
      end
    end

    def revert_eval_and_exec
      [:class_exec, :class_eval].each do |method|
        old_method = "_old_#{method}".to_sym
        singleton_class.send(:alias_method, method, old_method)
      end
    end

    def named_class_definition(child)
      trace = TracePoint.new(:end) do |point|
        next unless point.self == child
        trace.disable
        track_required_methods child
      end
      trace.enable
    end
  end
end
