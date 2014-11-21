# encoding: UTF-8
namespace :enviar_correos do
  desc "Enviar correo recordatorios a usuarios que cumplan mas de n dias sin entrar al sitio"
  task :correos_recordatorios => :environment do
  	UserMailer.enviar_correo_prueba.deliver
  end

end
