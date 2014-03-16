module CucumberStatistics
  class UnusedStepsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize unused_steps
      generate_html unused_steps
    end

    def generate_html unused_steps
      html = HtmlTemplate.new Configuration.unused_steps
      html.replace "PP_UNUSED_STEPS", format_unused_steps(unused_steps.all)
      html.output "unused_steps.html"
    end
  end
end