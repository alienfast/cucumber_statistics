require 'spec_helper'

module CucumberStatistics
  describe Renderer do

    subject(:step_statistics) { StepStatistics.new }
    subject(:overall_statistics) { OverallStatistics.new }

    before(:each) do
      # clean up before start, leave after in case we want to inspect it.
      Configuration.clean_tmp_dir

      overall_statistics.start_time = Time.now - 35
      overall_statistics.feature_count_inc
      overall_statistics.scenario_count_inc

      record 'my step 1', 1.100116
      record 'my step 1', 9.213553
      record 'my step 2', 3.100117
      record 'my step 2', 14.204407
      record 'my step 3', 1.500131
      record 'my step 3', 3.48993
      record 'my step 4', 4.21
      record 'my step 4', 4.21

      overall_statistics.end_time = Time.now
      step_statistics.calculate
    end


    describe 'render_step_statistics' do
      it 'should render content' do

        expect(File.exists?(Configuration.result_step_statistics)).to eql false

        absolute_file_name = Renderer.render_step_statistics step_statistics, overall_statistics
        expect(File.exists?(absolute_file_name)).to eql true

        #file = File.open(absolute_file_name, 'rb')
        #file_contents = file.read
      end
    end

    def record(step_name, duration)
      # fake a source for convenience
      step_statistics.record step_name, duration, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:8'
      overall_statistics.step_count_inc
    end
  end
end