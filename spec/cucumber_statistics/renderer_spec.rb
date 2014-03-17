require 'spec_helper'

module CucumberStatistics
  describe Renderer do

    subject do
      StepStatistics.new
    end

    before(:each) do
      # clean up before start, leave after in case we want to inspect it.
      Configuration.clean_tmp_dir

      record 'my step 1', 0.000116
      record 'my step 1', 9.213553
      record 'my step 2', 0.000117
      record 'my step 2', 14.204407
      record 'my step 3', 0.000131
      record 'my step 3', 3.48993

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

    def record(step_name, duration)
      # fake a source for convenience
      subject.record step_name, duration, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:8'
    end
  end
end