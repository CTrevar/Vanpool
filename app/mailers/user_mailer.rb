# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "serviciovanpool@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/signin'
    email_body = Configuracion.find(6).valor
    email_body = email_body.gsub(/(@usuario)/i, @user.name)
    mail(to: @user.email,
         body: email_body,
         content_type: "text/html",
         subject: 'Bienvenido a Vanpool')
  end

  def enviar_emails_recordatorios
    clientes_sin_entrar = Array.new
    clientes = Cliente.all
    clientes.each { |cliente|
      if cliente.user.last_sign_in_at.present?
        if (Time.zone.now - cliente.user.current_sign_in_at).to_i / 1.day >= 30
          clientes_sin_entrar << cliente
        end
      end
    }
    email_body = Configuracion.find(7).valor
    if clientes_sin_entrar.length >= 0
      clientes_sin_entrar.each { |c|
        # if email_body.downcase.include? "@usuario"
        email_body = email_body.gsub(/(@usuario)/i, c.user.name)
        # end
        Delayed::Job.enqueue(mail(to: c.user.email,
                                  body: email_body,
                                  content_type: "text/html",
                                  subject: 'En Vanpool te extrañamos'))
      }
    end
  end

  def enviar_correo_prueba
    puts DateTime.now.strftime('%d/%m/%Y- %T ===> ')
    mail(to: "alvaro9210@gmail.com",
         body: Configuracion.find(7).valor.gsub(/(@usuario)/i, Cliente.find(1).user.name),
         content_type: "text/html",
         subject: 'En Vanpool te extrañamos')
  end

end
