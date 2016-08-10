require 'spec_helper'

module CucumberStatistics
  describe StepStatistics do

    subject(:step_statistics) { StepStatistics.new }
    subject(:overall_statistics) { OverallStatistics.new }

    describe 'record' do
      it 'should create a record' do
        record 'my step', 50

        expect(step_statistics.all.count).to eq 1
        expect(step_statistics.all['my step'][:instances].count).to eq 1
        expect(step_statistics.all['my step'][:instances].first).to eq 50
      end

      it 'should support multiple instances of record' do
        record 'my step', 50
        record 'my step', 75

        expect(step_statistics.all.count).to eq 1
        expect(step_statistics.all['my step'][:instances].count).to eq 2
        expect(step_statistics.all['my step'][:instances].first).to eq 50
        expect(step_statistics.all['my step'][:instances].last).to eq 75
      end
    end

    describe 'calculate' do
      before(:each) do
        record 'my step', 25
        record 'my step', 50
        record 'my step', 75

        step_statistics.calculate
      end

      it 'should calculate the total elapsed time' do
        expect(step_statistics.all['my step'][:total]).to eq 150
      end

      it 'should calculate the number of count' do
        expect(step_statistics.all['my step'][:count]).to eq 3
      end

      it 'should calculate the average time' do
        expect(step_statistics.all['my step'][:average]).to eq 50
      end

      it 'should calculate the fastest step' do
        expect(step_statistics.all['my step'][:fastest]).to eq 25
      end

      it 'should calculate the slowest step' do
        expect(step_statistics.all['my step'][:slowest]).to eq 75
      end

      it 'should calculate the variation' do
        expect(step_statistics.all['my step'][:variation]).to eq 50
      end

      it 'should calculate the standard deviation' do
        expect(step_statistics.all['my step'][:standard_deviation]).to eq 25
      end

      it 'should calculate the variance' do
        expect(step_statistics.all['my step'][:variance]).to eq 625
      end
    end

    describe 'all' do
      before(:each) do
        record 'my step 1', 24
        record 'my step 1', 50
        record 'my step 2', 75
      end

      it 'should return all records' do
        expect(step_statistics.all.count).to eq 2
        step_statistics.all.each_with_index do |step_name, data, index|
          case index
            when 1
              expect(step_name).to eq 'my_step 2'
            when 2
              expect(step_name).to eq 'my_step 1'
          end
        end
      end
    end

    describe 'set operations' do
      before(:each) do
        record 'my step 1', 25
        record 'my step 1', 50
        record 'my step 2', 49
        record 'my step 2', 51
        record 'my step 3', 75
        record 'my step 3', 10

        step_statistics.calculate
      end

      describe 'sort_by_property' do
        it 'should sort all records by any property' do
          expect(step_statistics.sort_by_property(:total).first.first).to eq 'my step 1'
          expect(step_statistics.sort_by_property(:total).last.first).to eq 'my step 2'

          expect(step_statistics.sort_by_property(:fastest).first.first).to eq 'my step 3'
          expect(step_statistics.sort_by_property(:fastest).last.first).to eq 'my step 2'
        end
      end

      describe 'highest_average' do
        it 'should return the record with the highest average' do
          expect(step_statistics.highest_average.first).to eq 'my step 2'
        end
      end

      describe 'highest_elapsed_time' do
        it 'should return the record with the highest elapsed time' do
          expect(step_statistics.highest_total.first).to eq 'my step 2'
        end
      end

      describe 'greatest_variation' do
        it 'should return the record with the greatest variation between slow and fast' do
          expect(step_statistics.highest_variation.first).to eq 'my step 3'
        end
      end

      describe 'step_part_of_total' do
        it 'should return the total times of each step from largest to smallest' do
          expect(step_statistics.step_part_of_total).to eq [100.0, 85.0, 75.0]
        end
      end

      describe 'total_elapsed_time' do
        it 'should return the count of all steps' do
          expect(step_statistics.total_elapsed_time).to eq 260
        end
      end

      describe 'average_times_plot_data' do
        it 'should return all the averages sorted by average amount descending' do
          record 'my step 1', 25
          record 'my step 1', 50
          record 'my step 2', 49
          record 'my step 2', 51
          record 'my step 3', 75
          record 'my step 3', 10

          step_statistics.calculate

          expect(step_statistics.average_times_plot_data).to eq [50.0, 42.5, 37.5]
        end
      end

      describe 'total_times_plot_data' do
        it 'should return the total times of each step sorted by average amount descending' do
          record 'my step 1', 25
          record 'my step 1', 50
          record 'my step 3', 75
          record 'my step 3', 10

          step_statistics.calculate

          expect(step_statistics.total_times_plot_data).to eq [100.0, 170, 150.0]
        end
      end
    end

    describe 'sample_variance' do
      it 'should calculate the variance' do
        expect(step_statistics.sample_variance([1, 2, 3, 4, 5, 6])).to be_within(0.1).of(3.5)
        expect(step_statistics.sample_variance([2, 4, 4, 4, 5, 5, 7, 9])).to be_within(0.1).of(4.57)
        expect(step_statistics.sample_variance([25, 50, 75])).to be_within(0.1).of(625)
      end
    end

    describe 'standard_deviation' do
      it 'should calculate the standard deviation' do
        sample_variance = step_statistics.sample_variance([1, 2, 3, 4, 5, 6])
        expect(step_statistics.standard_deviation(sample_variance)).to be_within(0.1).of(1.87)

        sample_variance = step_statistics.sample_variance([2, 4, 4, 4, 5, 5, 7, 9])
        expect(step_statistics.standard_deviation(sample_variance)).to be_within(0.1).of(2.13)

        sample_variance = step_statistics.sample_variance([25, 50, 75])
        expect(step_statistics.standard_deviation(sample_variance)).to be_within(0.1).of(25)
      end
    end

    def record(step_name, duration)
      # fake a source for convenience
      step_statistics.record step_name, duration, '/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:8'
      #overall_statistics.step_count_inc
    end
  end
end