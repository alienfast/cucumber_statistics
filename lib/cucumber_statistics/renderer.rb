require 'haml'
require 'tilt/haml'

module CucumberStatistics
  class Renderer

    class << self

      def render_step_statistics step_statistics
        rendered_content = Tilt.new(File.expand_path('../view/step_statistics.html.haml', __FILE__)).render step_statistics

        absolute_file_name = Configuration.result_step_statistics
        File.open(absolute_file_name, 'w') do |f|
          f.write rendered_content
        end

        absolute_file_name
      end
    end
  end
end