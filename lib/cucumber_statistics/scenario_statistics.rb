module CucumberStatistics
  class ScenarioStatistics
    def initialize
      @all = Hash.new
    end

    def record scenario_name, duration, file_colon_line
      short_file_colon_line = file_colon_line[file_colon_line.index('features').to_i..-1]

      scenario_result = @all[short_file_colon_line]
      scenario_result ||= Hash.new
      scenario_result[:duration] = duration
      scenario_result[:scenario_name] = scenario_name

      @all[short_file_colon_line] ||= scenario_result
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
