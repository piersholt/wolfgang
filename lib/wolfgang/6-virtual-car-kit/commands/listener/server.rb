# frozen_string_literal: true

module Wolfgang
  class CommandListener
    # CommandServer
    module CommandServer
      PROG_SERVER = 'CommandListener [REP]'

      attr_reader :command_server_thread

      def reply_iteration(iteration)
        logger.debug(PROG) { "REP #{iteration}. Wait" }
        serialized_object = Server.recv
        command = deserialize(serialized_object)
        delegate(command)
      rescue IfYouWantSomethingDone
        logger.warn(PROG) { "Chain did not handle! (#{command})" }
      rescue StandardError => e
        logger.error(PROG) { e }
        e.backtrace.each { |line| logger.error(PROG) { line } }
      end

      def server_loop
        i = ITERATION_SEED
        loop do
          reply_iteration(i)
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
        logger.debug(PROG_SERVER) do
          "Server connection options: #{connection_options}"
        end
        Server.params(connection_options)
      end

      def start_server
        logger.debug(PROG) { '#start_server' }
        @command_server_thread = Thread.new do
          begin
            Thread.current[:name] = PROG_SERVER
            setup_server

            logger.debug(PROG_SERVER) { "Thread: #{PROG_SERVER} listen start!" }
            server_loop
            logger.debug(PROG_SERVER) { "Thread: #{PROG_SERVER} listen end!" }
          rescue StandardError => e
            logger.error(PROG_SERVER) { e }
            e.backtrace { |line| logger.error(PROG_SERVER) { line } }
          end
          logger.warn(PROG) { 'Thread ending!' }
        end
        add_thread(@command_server_thread)
      end

      alias start start_server
    end
  end
end
