module CucumberStatistics
  class ScenarioStatistics
    def initialize
      @all = Hash.new
    end

    def record scenario_name, duration, file_colon_line

      scenario_result = @all[scenario_name]
      scenario_result ||= Hash.new
      scenario_result[:duration] = duration
      begin
        file = file_colon_line[file_colon_line.index('features')..-1]
        scenario_result[:file] = file
      rescue Exception => e
        scenario_result[:file] = e.message
      end

      @all[scenario_name] ||= scenario_result
    end

    def calculate
    end

    def all
      @all
    end

    def sort_by_property property
      result = @all.sort {|a,b| a.last[property.to_sym] <=> b.last[property.to_sym]}
      result
    end

  end
end
