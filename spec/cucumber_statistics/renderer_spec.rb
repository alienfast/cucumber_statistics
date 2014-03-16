require 'spec_helper'

module CucumberStatistics
  describe Renderer do

    subject do
      StepStatistics.new
    end

    before(:each) do
      # clean up before start, leave after in case we want to inspect it.
      Configuration.clean_tmp_dir

      subject.record 'my step 1', 25
      subject.record 'my step 1', 50
      subject.record 'my step 2', 49
      subject.record 'my step 2', 51
      subject.record 'my step 3', 75
      subject.record 'my step 3', 10

      subject.calculate
    end


    describe 'render_step_statistics' do
      it 'should render content' do

        File.exists?(Configuration.result_step_statistics).should be_false

        absolute_file_name = Renderer.render_step_statistics subject
        File.exists?(absolute_file_name).should be_true

        #file = File.open(absolute_file_name, 'rb')
        #file_contents = file.read
      end
    end

    def fixture

    end
  end
end