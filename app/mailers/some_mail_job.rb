class SomeMailJob < Struct.new (:x)
  def perform
    UserMailer.enviar_correo_prueba_dj.deliver
  end
end