require 'spec_helper'

module CucumberStatistics
  describe Configuration do

    before do
      Configuration.clean_tmp_dir
    end

    it 'should auto create tmp_dir' do

      tmp_dir = Configuration.tmp_dir
      expect(Dir.exists?(tmp_dir)).to be_truthy

      Dir.delete tmp_dir
      tmp_dir = Configuration.tmp_dir
      expect(Dir.exists?(tmp_dir)).to be_truthy
    end
  end
end