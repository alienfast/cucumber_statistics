require 'spec_helper'

module CucumberStatistics
  describe UnusedSteps do
    subject do
      UnusedSteps.new
    end

    describe 'record' do
      it 'should create a record' do
        subject.record 'my_step', 'some code somewhere'
        expect(subject.all['my_step']).to eq 'some code somewhere'
      end
    end

    describe 'all' do
      it 'should return all records sorted alphabetically' do
        subject.record 'my_step 3', 'some code somewhere 3'
        subject.record 'my_step 2', 'some code somewhere 2'
        subject.record 'my_step 1', 'some code somewhere 1'

        expect(subject.all.count).to eq 3
        subject.all.each_with_index do |step_name, where, index|
          case index
            when 1
              expect(step_name).to eq 'my_step 1'
              expect(where).to eq 'some code somewhere 1'
            when 2
              expect(step_name).to eq 'my_step 2'
              expect(where).to eq 'some code somewhere 1'
            when 3
              expect(step_name).to eq 'my_step 3'
              expect(where).to eq 'some code somewhere 1'
          end
        end
      end
    end
  end
end