module CucumberStatistics

  class RendererHelper

    def name_td(results)
      %{<td title="#{results[1][:file]}">#{results[0]}</td>}
    end

    def scenario_name_td(name, result)
      %{<td title="#{result[:file]}">#{name}</td>}
    end

    def time_td(results, metric, *warning_results)
      duration = results[1][metric]

      %{<td #{warning_class(results, warning_results)} data-value="#{duration}" title="#{duration}">#{format(duration)}</td>}
    end

    def scenario_time_td(result)
      duration = result[:duration]

      %{<td data-value="#{duration}" title="#{duration}">#{format(duration)}</td>}
    end

    def warning_class(results, warning_results)

      if warning_results.nil? || warning_results.empty?
        should_warn = false
      else
        should_warn = (results[0].eql? warning_results[0][0])
      end
      if should_warn
        %{class="danger"}
      else
        ''
      end
    end

    def count_td(results, metric)
      value = results[1][metric]
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
