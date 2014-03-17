require 'spec_helper'

module CucumberStatistics
  describe StepStatistics do
    subject do
      StepStatistics.new
    end

    describe 'record' do
      it 'should create a record' do
        record "my step", 50

        subject.all.count.should == 1
        subject.all['my step'][:instances].count.should == 1
        subject.all['my step'][:instances].first.should == 50
      end

      it 'should support multiple instances of record' do
        record "my step", 50
        record "my step", 75

        subject.all.count.should == 1
        subject.all['my step'][:instances].count.should == 2
        subject.all['my step'][:instances].first.should == 50
        subject.all['my step'][:instances].last.should == 75
      end
    end

    describe 'calculate' do
      before(:each) do
        record "my step", 25
        record "my step", 50
        record "my step", 75

        subject.calculate
      end

      it 'should calculate the total elapsed time' do
        subject.all["my step"][:total].should == 150
      end

      it 'should calculate the number of count' do
        subject.all["my step"][:count].should == 3
      end

      it 'should calculate the average time' do
        subject.all["my step"][:average].should == 50
      end

      it 'should calculate the fastest step' do
        subject.all["my step"][:fastest].should == 25
      end
      
      it 'should calculate the slowest step' do
        subject.all["my step"][:slowest].should == 75
      end

      it 'should calculate the variation' do
        subject.all["my step"][:variation].should == 50
      end

      it 'should calculate the standard deviation' do
        subject.all["my step"][:standard_deviation].should == 25
      end

      it 'should calculate the variance' do
        subject.all["my step"][:variance].should == 625
      end
    end

    describe 'all' do
      before(:each) do
        record "my step 1", 24
        record "my step 1", 50
        record "my step 2", 75
      end

      it 'should return all records' do
        subject.all.count.should == 2
        subject.all.each_with_index do |step_name, data, index|
          case index
          when 1
            step_name.should == "my_step 2"
          when 2
            step_name.should == "my_step 1"
          end
        end
      end
    end

    describe 'set operations' do
      before(:each) do
        record "my step 1", 25
        record "my step 1", 50
        record "my step 2", 49
        record "my step 2", 51
        record "my step 3", 75
        record "my step 3", 10

        subject.calculate
      end

      describe 'sort_by_property' do
        it 'should sort all records by any property' do
          subject.sort_by_property(:total).first.first.should == "my step 1"
          subject.sort_by_property(:total).last.first.should == "my step 2"

          subject.sort_by_property(:fastest).first.first.should == "my step 3"
          subject.sort_by_property(:fastest).last.first.should == "my step 2"
        end
      end

      describe 'highest_average' do
        it 'should return the record with the highest average' do
          subject.highest_average.first.should == "my step 2"
        end
      end

      describe 'highest_elapsed_time' do
        it 'should return the record with the highest elapsed time' do
          subject.highest_total.first.should == "my step 2"
        end
      end

      describe 'greatest_variation' do
        it 'should return the record with the greatest variation between slow and fast' do
          subject.highest_variation.first.should == "my step 3"
        end
      end

      describe 'step_part_of_total' do
        it 'should return the total times of each step from largest to smallest' do
          subject.step_part_of_total.should == [100.0, 85.0, 75.0]
        end
      end

      describe 'total_elapsed_time' do
        it 'should return the count of all steps' do
          subject.total_elapsed_time.should == 260
        end
      end

      describe 'average_times_plot_data' do
        it 'should return all the averages sorted by average amount descending' do
          record "my step 1", 25
          record "my step 1", 50
          record "my step 2", 49
          record "my step 2", 51
          record "my step 3", 75
          record "my step 3", 10

          subject.calculate
          
          subject.average_times_plot_data.should == [50.0, 42.5, 37.5]
        end
      end

      describe 'total_times_plot_data' do
        it 'should return the total times of each step sorted by average amount descending' do
          record "my step 1", 25
          record "my step 1", 50
          record "my step 3", 75
          record "my step 3", 10

          subject.calculate

          subject.total_times_plot_data.should == [100.0, 170, 150.0]
        end
      end
    end

    describe 'sample_variance' do
      it 'should calculate the variance' do
        subject.sample_variance([1,2,3,4,5,6]).should be_within(0.1).of(3.5)
        subject.sample_variance([2,4,4,4,5,5,7,9]).should be_within(0.1).of(4.57)
        subject.sample_variance([25,50,75]).should be_within(0.1).of(625)
      end
    end

    describe 'standard_deviation' do
      it 'should calculate the standard deviation' do
        sample_variance = subject.sample_variance([1,2,3,4,5,6])
        subject.standard_deviation(sample_variance).should be_within(0.1).of(1.87)
        
        sample_variance = subject.sample_variance([2,4,4,4,5,5,7,9])
        subject.standard_deviation(sample_variance).should be_within(0.1).of(2.13)

        sample_variance = subject.sample_variance([25,50,75])
        subject.standard_deviation(sample_variance).should be_within(0.1).of(25)
      end
    end
  end
end