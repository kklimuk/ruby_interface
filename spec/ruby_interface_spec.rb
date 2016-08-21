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

    it do
      expect { subject }.to_not raise_error
    end
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