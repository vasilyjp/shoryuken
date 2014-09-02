module Shoryuken
  module Util
    class Pretty < Logger::Formatter
      # Provide a call() method that returns the formatted message.
      def call(severity, time, program_name, message)
        "#{time.utc.iso8601} #{Process.pid} TID-#{Thread.current.object_id.to_s(36)} #{severity}: #{message}\n"
      end
    end

    def self.logger
      @logger ||= begin
                    log = Logger.new(STDOUT)
                    log.level = Logger::INFO
                    log.formatter = Pretty.new
                    log
                  end
    end

    def logger
      Shoryuken::Util.logger
    end

    def constantize(camel_cased_word)
      names = camel_cased_word.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end
end
