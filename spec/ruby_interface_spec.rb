require 'spec_helper'

describe RubyInterface do
  let(:methods) { [:hello, :world] }

  let(:klass) do
    defined_methods = methods
    Class.new do
      include RubyInterface
      defines *defined_methods
    end
  end

  subject { subklass }

  context 'when there is an inherited method defined' do
    let(:klass) do
      defined_methods = methods
      Class.new do
        def self.inherited(_); taco end
        def self.taco; end

        include RubyInterface
        defines *defined_methods
      end
    end

    let(:subklass) do
      TEST_CLASS_INHERITED_1 = klass
      class TestClassInherited1 < TEST_CLASS_INHERITED_1; end
    end

    it do
      expect(klass).to receive(:taco)
      expect { subject }.to raise_error NotImplementedError, 'Expected TestClassInherited1 to define #hello, #world'
    end

    context 'when the methods are defined' do
      let(:subklass) do
        TEST_CLASS_INHERITED_2 = klass
        class TestClassInherited2 < TEST_CLASS_INHERITED_2
          def hello; end
          def world; end
        end
      end

      it do
        expect(klass).to receive(:taco)
        expect { subject }.to_not raise_error
      end
    end
  end

  context 'with an anonymous class' do
    let(:subklass) do
      subklass = Class.new(klass)
      subklass.class_eval {}
      subklass
    end

    it do
      expect { subject }.to raise_error NotImplementedError, 'Expected anonymous class to define #hello, #world'
    end

    context 'when the methods are defined' do
      let(:subklass) do
        subklass = Class.new(klass)
        subklass.class_eval do
          def hello; end
          def world; end
        end
        subklass
      end

      it { expect { subject }.to_not raise_error }
    end

    context 'when class_eval is called twice' do
      let(:subklass) do
        subklass = Class.new(klass)
        subklass.class_eval do
          def hello; end
          def world; end
        end
        subklass.class_eval {}
      end

      it do
        expect(klass).to receive(:track_required_methods).once
        expect { subject }.to_not raise_error
      end
    end
  end


  context 'with a named class' do
    context 'when the methods are not defined' do
      let(:subklass) do
        TEST_CLASS = klass
        class TestClass < TEST_CLASS; end
      end

      it do
        expect { subject }.to raise_error NotImplementedError, 'Expected TestClass to define #hello, #world'
      end
    end

    context 'when the methods are defined' do
      let(:subklass) do
        TEST_CLASS_2 = klass
        class TestClass2 < TEST_CLASS
          def hello; end
          def world; end
        end
      end

      it { expect { subject }.to_not raise_error }
    end

    context 'when the subclass has a subclass' do
      let(:subklass) do
        TEST_CLASS_3 = klass
        class TestClass3 < TEST_CLASS
          defines :banana

          def hello; end
          def world; end
        end
      end

      let(:sub_subklass) do
        class TestSubClass < TestClass3
          def banana; end
        end
      end

      it do
        expect { subject }.to_not raise_error
        expect { sub_subklass }.to_not raise_error
      end
    end
  end
end