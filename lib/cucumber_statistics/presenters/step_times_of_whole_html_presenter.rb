module CucumberStatistics
  class StepTimesOfWholeHtmlPresenter < UsageRecordHtmlPresenter
    def initialize step_statistics
      generate_html step_statistics
    end

    def generate_html step_statistics
      html = HtmlTemplate.new Configuration.step_times_of_whole

      html.replace "PP_STEP_TOTAL_TIMES_PLOT_DATA", step_statistics.step_part_of_total.join(',')
      html.replace "PP_TOTAL_ELAPSED_TIME", step_statistics.total_elapsed_time / 60

      html.output "step_times_of_whole.html"
    end
  end
end