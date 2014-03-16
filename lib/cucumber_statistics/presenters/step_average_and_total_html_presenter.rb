module CucumberStatistics
  class StepAverageAndTotalHtmlPresenter < UsageRecordHtmlPresenter
    def initialize step_statistics
      generate_html step_statistics
    end

    def generate_html step_statistics
      html = HtmlTemplate.new Configuration.step_average_and_total

      html.replace "PP_HIGHEST_TOTAL_STEP_TIME", step_statistics.highest_elapsed_time.last[:total]
      html.replace "PP_HIGHEST_AVERAGE_STEP_TIME", step_statistics.highest_average.last[:average]
      html.replace "PP_AVERAGE_TIMES_PLOT_DATA", step_statistics.average_times_plot_data.join(',')
      html.replace "PP_TOTAL_TIMES_PLOT_DATA", step_statistics.total_times_plot_data.join(',')
      
      html.output "step_average_and_total.html"
    end
  end
end