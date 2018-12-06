require 'logger'

RESET = '0'
LIGHT_GRAY = '37'
GREEN = '32'
YELLOW = '33'
RED = '31'
MAGENTA = '35'


def gray
  "\e[#{LIGHT_GRAY}m"
end

def green
  "\e[#{GREEN}m"
end

def yellow
  "\e[#{YELLOW}m"
end

def red
  "\e[#{RED}m"
end

def magenta
  "\e[#{MAGENTA}m"
end

def clear
  "\e[#{RESET}m"
end

def get_logger
  l = Logger.new(STDOUT)
  l.formatter = proc do |severity, time, progname, msg|
      severity_to_colour_map = {
        'DEBUG' => gray,
        'INFO' => green,
        'WARN' => yellow,
        'ERROR' => red,
        'FATAL' => red,
        'UNKNOWN' => magenta,
        'ANY' => magenta,
      }
      color = severity_to_colour_map[severity]

      formatted_severity = sprintf("%-5s",severity)
      formatted_progname = sprintf("%20s",progname)
      # formatted_progname_string =  "[#{formatted_progname}]"


      # formatted_time = time.strftime("%y-%m-%d %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)
      # formatted_time = time.strftime("%y-%m-%d %H:%M:%S")
      formatted_time = time.strftime("%H:%M:%S")

      msg.strip! rescue StandardError

      #"\e[0;37m#{formatted_time}\e[0m [\e[#{color}m#{formatted_severity}\e[0m] #{msg.strip} (pid:#{$$})\n"
      m = "#{gray}#{formatted_time}#{clear} "\
          "[#{color}#{formatted_severity}#{clear}] "\
          "[#{formatted_progname}#{clear}] "\
          "#{msg}#{clear}"
      m.concat("\n") unless severity == Logger::UNKNOWN
    end

  l.sev_threshold=(Logger::INFO)

  l
end
