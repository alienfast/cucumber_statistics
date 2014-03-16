require 'spec_helper'
require 'ap'

module CucumberStatistics
  describe UnusedSteps do
    subject do
      UnusedSteps.new
    end

    describe 'record' do
      it 'should create a record' do
        subject.record "my_step", "some code somewhere"

        subject.all['my_step'].should == "some code somewhere"
      end
    end

    describe 'all' do
      it 'should return all records sorted alphabetically' do
        subject.record "my_step 3", "some code somewhere 3"
        subject.record "my_step 2", "some code somewhere 2"
        subject.record "my_step 1", "some code somewhere 1"

        subject.all.count.should == 3
        subject.all.each_with_index do |step_name, where, index|
          case index
          when 1
            step_name.should == "my_step 1"
            where.should == "some code somewhere 1"
          when 2
            step_name.should == "my_step 2"
            where.should == "some code somewhere 1"
          when 3
            step_name.should == "my_step 3"
            where.should == "some code somewhere 1"
          end
        end
      end
    end
  end
end