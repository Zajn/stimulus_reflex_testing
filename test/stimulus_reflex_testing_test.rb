require "test_helper"

class StimulusReflexTestingTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::StimulusReflexTesting::VERSION
  end

  def test_includes_version_number
    mock = MiniTest::Mock.new
    opts = { channel: 'TestChannel', element: 'TestElement', url: 'https://test.xyz', method_name: 'test' }
    mock.expect(:call, true) do |channel, element:, url:, method_name:, params:, client_attributes:|
      assert_equal(::StimulusReflex::VERSION, client_attributes[:version])
    end

    TestReflexClass.stub(:new, mock) do
      TestClass.new.build_reflex(opts)
    end
    mock.verify
  end
end

class TestClass
  include StimulusReflex::TestCase::Behavior

  def self.reflex_class
    TestReflexClass
  end
end

class TestReflexClass
  def initialize(channel, url:, element:, method_name:, params:, client_attributes:); true; end
end
