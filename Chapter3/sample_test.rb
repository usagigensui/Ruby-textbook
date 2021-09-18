require 'minitest/autorun'

class SampleTsst < Minitest::Test
  def test_sample
    assert_equal 'RUBY', 'ruby'.upcase
  end
end