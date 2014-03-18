# http://stackoverflow.com/a/3779913/2363935
module MethodInterception
  def before_filter(*meths)
    return @wrap_next_method = true if meths.empty?
    meths.delete_if {|meth| wrap(meth) if method_defined?(meth) }
    @intercepted_methods += meths
  end

  private

  def wrap(meth)
    old_meth = instance_method(meth)
    define_method(meth) do |*args, &block|
      puts 'before'
      #send(before_method, *args)
      old_meth.bind(self).(*args, &block)
      puts 'after'
    end
  end

  def method_added(meth)
    return super unless @intercepted_methods.include?(meth) || @wrap_next_method
    return super if @recursing == meth

    @recursing = meth # protect against infinite recursion
    wrap(meth)
    @recursing = nil
    @wrap_next_method = false

    super
  end

  def self.extended(klass)
    klass.instance_variable_set(:@intercepted_methods, [])
    klass.instance_variable_set(:@recursing, false)
    klass.instance_variable_set(:@wrap_next_method, false)
  end
end

module Cucumber
  module Cli
    class Configuration
      extend MethodInterception

      #def formatters(runtime)
      #  @options[:formats] << [v, @out_stream]
      #end

      before_filter(:build_tree_walker, :add_cucumber_statistics_formatter)

      def add_cucumber_statistics_formatter
        puts 'say goodbye'
      end

      before_filter
      #
      #def say_ahh
      #  puts 'ahh'
      #end
    end
  end
end