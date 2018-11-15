require 'logger'

def get_logger
  l = Logger.new(STDOUT)
  l.formatter = proc do |severity, time, progname, msg|
      severity_to_colour_map = {'DEBUG'=>'0;37', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'31', 'UNKNOWN'=>'37'}
      # severity_to_abrv_map = { 'DEBUG': 'D', 'INFO': 'I', 'WARN': 'W', 'ERROR': 'E', 'FATAL': 'F', 'UNKNOWN': '?'}
      color = severity_to_colour_map[severity]

      formatted_severity = sprintf("%-5s",severity)
      formatted_progname = sprintf("%20s",progname)
      formatted_progname_string =  "[#{formatted_progname}]"


      # formatted_time = time.strftime("%y-%m-%d %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)
      # formatted_time = time.strftime("%y-%m-%d %H:%M:%S")
      formatted_time = time.strftime("%H:%M:%S")

      msg.strip! rescue StandardError

      #"\033[0;37m#{formatted_time}\033[0m [\033[#{color}m#{formatted_severity}\033[0m] #{msg.strip} (pid:#{$$})\n"
      m = "\033[0;37m#{formatted_time}\033[0m [\033[#{color}m#{formatted_severity}\033[0m] #{formatted_progname_string} #{msg}"
      m.concat("\n") unless severity == Logger::UNKNOWN
    end

  l.sev_threshold=(Logger::DEBUG)

  l
end
