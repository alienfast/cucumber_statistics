module CucumberStatistics
  class UsageRecordHtmlPresenter
    def format_usage metric_results
      step_name = metric_results.first
      step_usage = metric_results.last
      
      html = "<table><trbody>"
      html = "#{html}<tr><th style='text-align:right;'>step</th><td style='padding-left:0.6em;'><pre>#{step_name}</pre></td></tr>"
      step_usage.each do |key, value|
        next if key == :instances
        
        html = "#{html}<tr><th style='text-align:right;'>#{key}</th><td style='padding-left:0.6em;'><pre>#{value}</pre></td></tr>"
      end
      html = "#{html}</trbody></table>"

      html
    end

    def format_unused_steps all_unused
      html = "<table><trbody>"
      html = "#{html}<tr><th style='text-align:right;'>step</th><th style='text-align:left;'>where</th></tr>"

      all_unused.each do |step_name, where|
        html = "#{html}<tr><td style='text-align:right;'>#{step_name}</th><td style='text-align:left; padding-left:0.6em;'><pre>#{where}</pre></td></tr>"
      end

      html = "#{html}</trbody></table>"
      html
    end

    def format_all all_usage
      output = ""
      
      all_usage.each do |result|
        output = "#{output}#{format_usage(result)}<hr/>"
      end

      output
    end
  end
end