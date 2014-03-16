module CucumberStatistics
  class AllUsageResultsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize step_statistics
      generate_html step_statistics
    end

    def generate_html step_statistics
      html = HtmlTemplate.new Configuration.all_usage_results
      html.replace "PP_STEP_HIGHEST_AVERAGE", format_usage(step_statistics.highest_average)
      html.replace "PP_STEP_HIGHEST_ELAPSED_TIME", format_usage(step_statistics.highest_elapsed_time)
      html.replace "PP_STEP_GREATEST_VARIATION", format_usage(step_statistics.greatest_variation)
      html.replace "PP_ALL_STEPS", format_all(step_statistics.all)
      html.output "all_usage_results.html"
    end
  end
end