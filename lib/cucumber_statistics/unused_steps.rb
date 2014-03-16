module CucumberStatistics
  class UnusedSteps
    def initialize
      @all = Hash.new
    end

    def record step_name, where
      result = @all[step_name]
      result = where

      @all[step_name] ||= result
    end

    def all
      @all
    end
  end
end