module CucumberStatistics
  class Formatter
    def initialize(step_mother, io, options)
      @step_mother = step_mother
      @io = io
      @options = options

      @step_statistics = StepStatistics.new
      @unused_steps = UnusedSteps.new
    end

    #call backs
    def before_step(step)
      @start_time = Time.now
    end

    def before_step_result(*args)
      @duration = Time.now - @start_time
    end

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)

      step_definition = step_match.step_definition
      unless step_definition.nil? # nil if it's from a scenario outline
        @step_statistics.record step_definition.regexp_source, @duration
      end
    end

    def after_features(features)

      # gather unused steps
      @step_mother.unmatched_step_definitions.each do |step_definition|
        @unused_steps.record step_definition.regexp_source, step_definition.file_colon_line
      end

      @step_statistics.calculate

      Renderer.render_step_statistics @step_statistics

      #AllUsageResultsHtmlPresenter.new @step_statistics
      #UnusedStepsHtmlPresenter.new @unused_steps
      #StepAverageAndTotalHtmlPresenter.new @step_statistics
      #StepTimesOfWholeHtmlPresenter.new @step_statistics
    end
  end
end