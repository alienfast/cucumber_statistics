module CucumberStatistics
  class FeatureStatistics
    def initialize
      @all = Hash.new
    end

    def record feature_name, duration, file
      short_file = file[file.index('features').to_i..-1]

      feature_result = @all[short_file]
      feature_result ||= Hash.new
      feature_result[:duration] = duration
      feature_result[:feature_name] = feature_name

      @all[short_file] ||= feature_result
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
