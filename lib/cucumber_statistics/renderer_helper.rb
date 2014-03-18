module CucumberStatistics

  class RendererHelper

    def name_td(step_results)
      %{<td title="#{step_results[1][:file]}">#{step_results[0]}</td>}
    end

    def time_td(step_results, metric, *warning_step_results)
      duration = step_results[1][metric]

      %{<td #{warning_class(step_results, warning_step_results)} data-value="#{duration}">#{format(duration)}</td>}
    end

    def warning_class(step_results, warning_step_results)

      if warning_step_results.nil? || warning_step_results.empty?
        should_warn = false
      else
        should_warn = (step_results[0].eql? warning_step_results[0][0])
      end
      if should_warn
        %{class="danger"}
      else
        ''
      end
    end

    def count_td(step_results, metric)
      value = step_results[1][metric]
      %{<td data-value="#{value}">#{value}</td>}
    end

    def format (ts)

      return '-' if ts.nil? || ts == 0

      #find the seconds
      seconds = ts % 60

      #find the minutes
      minutes = (ts / 60) % 60

      #find the hours
      hours = (ts/3600)

      formatted_h = hours.to_i
      formatted_m = minutes.to_i
      formatted_s = seconds.to_i
      formatted_ms = Time.at(seconds).utc.strftime("%3N")

      # http://apidock.com/ruby/DateTime/strftime
      if hours >= 1
        #result = Time.at(ts).utc.strftime("%Hh %Mm %S.%3Ns")
        result = "#{formatted_h}h #{formatted_m}m #{formatted_s}.#{formatted_ms}s"
      elsif minutes >= 1
        #result = Time.at(ts).utc.strftime("%Mm %S.%3Ns")
        result = "#{formatted_m}m #{formatted_s}.#{formatted_ms}s"
      elsif formatted_ms.to_i == 0 && formatted_s == 0 && formatted_h == 0
        result = "< #{formatted_s}.#{formatted_ms}s"
      else
        #result = Time.at(ts).utc.strftime("%S.%3Ns")
        result = "#{formatted_s}.#{formatted_ms}s"
      end

      result
    end

    def format_date_time (time)
      time.strftime("%m/%d/%Y at %I:%M%p")
    end
  end
end
