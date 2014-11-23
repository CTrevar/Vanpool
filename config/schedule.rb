#encoding: utf-8
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment, "development"
set :path, "/home/Vanpool"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

require File.expand_path(File.dirname(__FILE__) + "/environment")

# every 3.minutes do
# 	command "echo 'cron nom nom'"
# end
# require "#{Rails.root}/config/environment.rb"
@dias = Configuracion.find(8)

every eval(@dias.valor).to_i.days do
  runner "UserMailer.enviar_correo_prueba.deliver"
end

every 30.days do
  runner "Viaje.generar_viajes_mensuales"
end