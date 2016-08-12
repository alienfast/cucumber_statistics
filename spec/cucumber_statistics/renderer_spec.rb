require 'spec_helper'

module CucumberStatistics
  describe Renderer do

    subject(:step_statistics) { StepStatistics.new }
    subject(:scenario_statistics) { ScenarioStatistics.new }
    subject(:feature_statistics) { FeatureStatistics.new }
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

      record_scenario 'my scenario 1', 10.2, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:8'
      record_scenario 'my scenario 2', 30.2, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:13'
      record_scenario 'my scenario 3', 17.342, '/Users/kross/alienfast/acme/features/user experience/view.feature:2'
      record_scenario 'my scenario 3', 3.2, '/Users/kross/alienfast/acme/features/user experience/view.feature:23'

      record_feature 'my admin feature', 50, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature'
      record_feature 'my user feature', 50, '/Users/kross/alienfast/acme/features/user experience/view.feature'

      overall_statistics.end_time = Time.now
      step_statistics.calculate
    end


    describe 'render statistics' do
      context 'should render content' do

        it 'renders combined results file' do
          expect(File.exists?(Configuration.result_combined_statistics)).to eql false
          absolute_file_name = Renderer.render_combined_statistics step_statistics, scenario_statistics, feature_statistics, overall_statistics
          expect(File.exists?(absolute_file_name)).to eql true
        end

      end
    end

    def record(step_name, duration)
      # fake a source for convenience
      step_statistics.record step_name, duration, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:8'
      overall_statistics.step_count_inc
    end

    def record_scenario(scenario_name, duration, file_colon_line)
      # fake a source for convenience
      scenario_statistics.record scenario_name, duration, file_colon_line
      overall_statistics.scenario_count_inc
    end

    def record_feature(feature_name, duration, file_colon_line)
      # fake a source for convenience
      feature_statistics.record feature_name, duration, file_colon_line
      overall_statistics.feature_count_inc
    end
  end
end