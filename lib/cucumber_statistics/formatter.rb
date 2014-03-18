module CucumberStatistics
  class Formatter
    def initialize(step_mother, io, options)
      @step_mother = step_mother
      @io = io
      @options = options

      @overall_statistics = OverallStatistics.new
      @step_statistics = StepStatistics.new
      @unused_steps = UnusedSteps.new
    end

    #----------------------------------------------------
    # Step callbacks
    #----------------------------------------------------
    def before_step(step)
      @step_start_time = Time.now
    end

    def before_step_result(*args)
      @step_duration = Time.now - @step_start_time
    end

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)

      step_definition = step_match.step_definition
      unless step_definition.nil? # nil if it's from a scenario outline
        @step_statistics.record step_definition.regexp_source, @step_duration, file_colon_line
      end
    end


    #----------------------------------------------------
    # Overall callbacks
    #----------------------------------------------------
    #def before_feature(feature)
    #end
    def scenario_name(keyword, name, file_colon_line, source_indent)
      @overall_statistics.scenario_count_inc
    end

    def after_step(step)
      @overall_statistics.step_count_inc
    end

    def after_feature(feature)
      @overall_statistics.feature_count_inc
    end

    def before_features(features)
      @overall_statistics.start_time = Time.now
    end

    def after_features(features)

      @overall_statistics.end_time = Time.now

      # gather unused steps
      @step_mother.unmatched_step_definitions.each do |step_definition|
        @unused_steps.record step_definition.regexp_source, step_definition.file_colon_line
      end

      @step_statistics.calculate

      Renderer.render_step_statistics @step_statistics, @overall_statistics
    end
  end
end