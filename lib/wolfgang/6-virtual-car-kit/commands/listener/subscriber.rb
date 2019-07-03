# frozen_string_literal: true

module Wolfgang
  class CommandListener
    # CommandSubscriber
    module CommandSubscriber
      PROG_SUB = 'CommandListener [SUB]'

      attr_reader :command_subscriber_thread

      def pop_and_delegate(iteration)
        logger.debug(PROG) { "SUB #{iteration}. Wait" }
        serialized_object = Subscriber.recv
        command = deserialize(serialized_object)
        delegate(command)
      rescue IfYouWantSomethingDone
        logger.warn(PROG) { "Chain did not handle! (#{command})" }
      rescue StandardError => e
        logger.error(PROG) { e }
        e.backtrace.each { |line| logger.error(PROG) { line } }
      end

      def subscriber_loop
        i = ITERATION_SEED
        loop do
          pop_and_delegate(i)
          i += 1
        end
      rescue StandardError => e
        logger.error(PROG) { e }
        e.backtrace.each do |line|
          logger.error(PROG) { line }
        end
      end

      def start_subscriber
        logger.debug(PROG) { '#start_subscriber' }
        @command_subscriber_thread = Thread.new do
          begin
            Thread.current[:name] = PROG_SUB
            logger.debug(PROG_SUB) { "Delay: #{DELAY} seconds." }
            Kernel.sleep(DELAY)

            connection_options = {
              port: ENV['subscriber_port'],
              host: ENV['subscriber_host']
            }
            logger.debug(PROG_SUB) do
              "Subscriber connection options: #{connection_options}"
            end
            Subscriber.params(connection_options)

            logger.debug(PROG_SUB) { "Thread: #{PROG_SUB} listen start!" }
            subscriber_loop
            logger.debug(PROG_SUB) { "Thread: #{PROG_SUB} listen end!" }
          rescue StandardError => e
            logger.error(PROG_SUB) { e }
            e.backtrace.each { |line| logger.error(PROG_SUB) { line } }
          end
          logger.warn(PROG_SUB) { 'Listening thread is ending?' }
        end
        add_thread(@command_subscriber_thread)
      end

      alias listen start_subscriber
    end
  end
end
