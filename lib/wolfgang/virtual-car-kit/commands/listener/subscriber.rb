# frozen_string_literal: true

module Wolfgang
  class CommandListener
    # CommandSubscriber
    module CommandSubscriber
      PROG_SUB = 'CommandSubscriber'
      LOG_CALL_START_SUB = '#start_subscriber'
      LOG_THREAD_END = 'Thread ending!'

      attr_reader :command_subscriber_thread

      def process_subscription(iteration)
        logger.debug(PROG_SUB) { "SUB #{iteration}. Wait" }
        serialized_object = Yabber::Subscriber.receive_message
        command = deserialize(serialized_object)
        delegate(command)
      rescue Yabber::IfYouWantSomethingDone
        logger.warn(PROG_SUB) { "Chain did not handle! (#{command})" }
      rescue StandardError => e
        logger.error(PROG_SUB) { e }
        e.backtrace.each { |line| logger.error(PROG_SUB) { line } }
        # Error must be raised as any exceptions in the message parsing
        # will cause server_loop to go into death spiral.
        raise e
      end

      def subscriber_loop
        i = ITERATION_SEED
        loop do
          process_subscription(i)
          i += 1
        end
      end

      def setup_subscriber
        logger.debug(PROG_SUB) { "Delay: #{DELAY} seconds." }
        Kernel.sleep(DELAY)

        connection_options = {
          port: ENV['subscriber_port'],
          host: ENV['subscriber_host']
        }
        logger.info(PROG_SUB) do
          "Subscriber connection options: #{connection_options}"
        end
        Yabber::Subscriber.params(connection_options)
      end

      def start_subscriber
        logger.debug(PROG) { LOG_CALL_START_SUB }
        @command_subscriber_thread = Thread.new do
          begin
            thread_name(PROG_SUB)
            setup_subscriber

            logger.debug(PROG_SUB) { "Thread: #{PROG_SUB} listen start!" }
            subscriber_loop
            logger.debug(PROG_SUB) { "Thread: #{PROG_SUB} listen end!" }
          rescue StandardError => e
            logger.error(PROG_SUB) { e }
            e.backtrace.each { |line| logger.error(PROG_SUB) { line } }
          end
          logger.warn(PROG_SUB) { LOG_THREAD_END }
        end
        add_thread(@command_subscriber_thread)
        true
      end

      alias listen start_subscriber
    end
  end
end
