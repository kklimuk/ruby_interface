require 'ruby_interface/version'
require 'awesome_print'

module RubyInterface
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def defines(*args)
      @methods_to_define ||= []
      @methods_to_define += args
    end

    def inherited(klass)
      trace = TracePoint.new(:end) do |point|
        next unless point.self == klass
        missing_methods = @methods_to_define - klass.instance_methods(false)
        trace.disable

        next if missing_methods.empty?

        message = "Expected #{klass.name} to define "
        message << missing_methods.map { |method| "##{method}" }.join(', ')
        raise NotImplementedError, message
      end
      trace.enable
    end
  end
end
