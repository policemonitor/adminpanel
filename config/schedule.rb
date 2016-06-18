# Notice for HOW TO USE IT

# First run:
# => Create task for cron: # whenever -w
# -  Its configuration is in schedule.rb
# => Check is it running:  # crontab -l
# => Run in DEV mode # whenever --update-crontab --set environment='development'

# Every reboot
# => Run support server on port 5000
# => Run main server on port whenever you like

# Help: whenever --help


set :output, File.join(Whenever.path, "log", "cron.log")

every 1.minute do
  runner "Synchronization.daemon_synchronize"
end

every 1.minute do
  runner "Synchronization.daemon_unlock"
end
