namespace :wolfgang do
  commands = :start, :stop, :restart
  commands.each do |command|
    desc "#{command.capitalize} Thin"
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        execute :echo, current_path
        within current_path do
          execute :rbenv, "sudo /etc/init.d/thin #{command}"
        end
      end
    end
  end
end

namespace :scp do
  desc 'Upload source.'
  task :source do
    on roles(:development) do |host|
      hostname = host.hostname
      username = host.user

      restricted_files = %w(.git .gitignore .ruby-version log)

      list = %x(ls -A).split
      restricted_files.each { |file| list.delete(file) }
      # puts %x`scp -r . #{username}@#{hostname}:#{fetch :deploy_to}`
      file_arg = list.join(' ')
      puts %x`scp -B -C -r #{file_arg} #{username}@#{hostname}:#{fetch :deploy_to}`
    end
  end

  desc 'Upload lib'
  task :lib do
    on roles(:development) do |host|
      hostname = host.hostname
      username = host.user

      puts %x`scp -B -C -r lib #{username}@#{hostname}:#{fetch :deploy_to}`
    end
  end
end
