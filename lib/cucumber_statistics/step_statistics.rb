module CucumberStatistics
  class StepStatistics
    def initialize
      @all = Hash.new
    end

    def record step_name, duration, file_colon_line

      # "/Users/kross/alienfast/acme/features/account management/admin_cancel_account.feature:8"
      step_results = @all[step_name]
      step_results ||= Hash.new
      step_results[:instances] ||= []
      step_results[:instances] << duration
      begin
        file = file_colon_line[file_colon_line.index('features')..-1]
        step_results[:file] = file
      rescue Exception => e
        step_results[:file] = e.message
      end

      @all[step_name] ||= step_results
    end

    def calculate
      @all.each do |step_name, step_results|
        step_results[:total] = step_results[:instances].inject{|sum,x| sum + x }
        step_results[:count] = step_results[:instances].count
        step_results[:average] = step_results[:total].to_f / step_results[:count].to_f
        step_results[:fastest] = step_results[:instances].sort.first
        step_results[:slowest] = step_results[:instances].sort.last
        step_results[:variation] = step_results[:slowest] - step_results[:fastest]
        step_results[:variance] = self.sample_variance step_results[:instances]
        step_results[:standard_deviation] = self.standard_deviation step_results[:variance]
      end
    end

    def all
      @all
    end

    def sort_by_property property
      result = @all.sort {|a,b| a.last[property.to_sym] <=> b.last[property.to_sym]}
      result
    end

    def highest_average
      sort_by_property(:average).reverse.first
    end

    def highest_total
      sort_by_property(:total).reverse.first
    end

    def highest_variation
      sort_by_property(:variation).reverse.first
    end

    def average_times_plot_data
      @all.map {|step_name, data| data[:average].to_f}.sort.reverse
    end

    def total_times_plot_data
      sort_by_property(:average).reverse.map {|step_name, data| data[:total].to_f}
    end

    def step_part_of_total
      @all.map {|step_name, data| data[:total]}.sort.reverse
    end

    def total_elapsed_time
      @all.map {|step_name, data| data[:total]}.inject{|sum,x| sum + x }
    end

    def sample_variance data
      count = data.count
      average = data.inject{|sum,x| sum + x } / count.to_f

      return nil if count <= 1
      
      sum = data.inject(0){|acc,i|acc.to_f + (i.to_f - average)**2.0}

      return 1 / (count.to_f - 1.0) * sum.to_f
    end

    def standard_deviation sample_variance
      return nil if sample_variance.nil?
      
      return Math.sqrt(sample_variance)
    end
  end
end