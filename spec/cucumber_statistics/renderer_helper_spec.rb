require 'spec_helper'

module CucumberStatistics
  describe RendererHelper do

    describe '#format' do
      it 'formats milliseconds' do
        assert_format(0.000123, '< 0.000s')
      end
      it 'formats seconds' do
        assert_format(3.123456, '3.123s')
      end
      it 'formats minutes' do
        assert_format(60, '1m 0.000s')
        assert_format(60.12345, '1m 0.123s')
      end
      it 'formats hours' do
        assert_format(3600, '1h 0m 0.000s')
        assert_format(3600.12345, '1h 0m 0.123s')
      end
    end

    def assert_format(duration, expectation)
      expect(RendererHelper.new.format duration).to eq(expectation)
    end
  end
end