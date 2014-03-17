module CucumberStatistics

  class RendererHelper

    def format (ts)

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
      else
        #result = Time.at(ts).utc.strftime("%S.%3Ns")
        result = "#{formatted_s}.#{formatted_ms}s"
      end

      result
    end
  end
end
