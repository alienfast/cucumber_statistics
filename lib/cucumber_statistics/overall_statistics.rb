require 'virtus'

module CucumberStatistics
  class OverallStatistics
    include Virtus.model

    attribute :start_time, Time
    attribute :end_time, Time
    attribute :feature_count, Integer, default: 0
    attribute :scenario_count, Integer, default: 0
    attribute :step_count, Integer, default: 0

    def duration
      end_time - start_time
    end

    def feature_count_inc
      self.feature_count += 1
    end

    def scenario_count_inc
      self.scenario_count += 1
    end

    def step_count_inc
      self.step_count += 1
    end
  end
end