# frozen_string_literal: true

module Wolfgang
  class CommandListener
    # CommandServer
    module CommandServer
      PROG_SERVER = 'CommandServer'
      LOG_CALL_START_SERVER = '#start_server'
      LOG_THREAD_END = 'Thread ending!'

      attr_reader :command_server_thread

      def process_request(iteration)
        logger.debug(PROG_SERVER) { "REP #{iteration}. Wait" }
        serialized_object = Yabber::Server.receive_message
        command = deserialize(serialized_object)
        delegate(command)
      rescue Yabber::IfYouWantSomethingDone
        logger.warn(PROG_SERVER) { "Chain did not handle! (#{command})" }
      rescue StandardError => e
        logger.error(PROG_SERVER) { e }
        e.backtrace.each { |line| logger.error(PROG_SERVER) { line } }
        # Error must be raised as any exceptions in the message parsing
        # will cause server_loop to go into death spiral.
        raise e
      end

      def server_loop
        i = ITERATION_SEED
        loop do
          process_request(i)
          i += 1
        end
      end

      def setup_server
        logger.debug(PROG_SERVER) { "Delay: #{DELAY} seconds." }
        Kernel.sleep(DELAY)

        connection_options = {
          port: ENV['server_port'],
          host: ENV['server_host']
        }
        logger.info(PROG_SERVER) do
          "Server connection options: #{connection_options}"
        end
        Yabber::Server.params(connection_options)
      end

      def start_server
        logger.debug(PROG) { LOG_CALL_START_SERVER }
        @command_server_thread = Thread.new do
          begin
            thread_name(PROG_SERVER)
            setup_server

            logger.debug(PROG_SERVER) { "Thread: #{PROG_SERVER} listen start!" }
            server_loop
            logger.debug(PROG_SERVER) { "Thread: #{PROG_SERVER} listen end!" }
          rescue StandardError => e
            logger.error(PROG_SERVER) { e }
            e.backtrace { |line| logger.error(PROG_SERVER) { line } }
          end
          logger.warn(PROG_SERVER) { LOG_THREAD_END }
        end
        add_thread(@command_server_thread)
        true
      end

      alias start start_server
    end
  end
end
