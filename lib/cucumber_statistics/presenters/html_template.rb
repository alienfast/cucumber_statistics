module CucumberStatistics
  class HtmlTemplate
    def initialize template_path
      @content = ''

      File.open(template_path) do |file|
        while line = file.gets
          @content = "#{@content}#{line}"
        end
      end
    end

    def output filename
      absolute_file_name = Configuration.tmp_file(filename)
      File.open(absolute_file_name, 'w') do |file|
        file.write @content
      end
      absolute_file_name
    end

    def content
      @content
    end

    def replace to_remove, to_insert
      @content = "#{@content.split(to_remove).first}#{to_insert}#{@content.split(to_remove).last}"
    end
  end
end