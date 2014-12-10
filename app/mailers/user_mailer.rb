# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "serviciovanpool@gmail.com"


  def welcome_email(user)
    @user = user
    # @url  = 'http://localhost:3000/signin'
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
        email_body = email_body.gsub(/(@usuario)/i, c.user.name)
        mail(to: c.user.email,
             body: email_body,
             content_type: "text/html",
             subject: 'En Vanpool te extrañamos')
        # puts "ID:#{c.user.id}  Name: #{c.user.name}  Email: #{c.user.email} Dias: #{((Time.zone.now - c.user.current_sign_in_at).to_i / 1.day)}"
      }
    else
      puts "No hay usuarios con mas de 30 dias sin entrar"
    end
  end


  def enviar_email_pago(response_hash, current_cliente)
    @response_hash = response_hash
    @current_cliente = current_cliente
    email_body = "<h3
                    Recarga realizada con éxito.
                  </h3>
                  <table >
                    <thead>
                      <tr>
                        <td colspan='2'>
                          Redes de Aventones SAPI de CV.
                        </td>
                        <td align='right'>
                          <small class='pull-right'>Fecha: #{Date.parse(@response_hash["creation_date"]).strftime("%d/%^b/%Y")} </small>
                        </td>
                      </tr>
                    </thead>
                    <tr>
                      <td>
                        De
                        <address>
                          <strong>Redes de Aventones SAPI de CV.</strong><br>
                          Monte Cáucaso 993<br>
                          Col. Lomas de Chapultepec<br>
                          Del. Miguel Hidalgo, México<br>
                          D.F., México, 11000<br>
                          RFC: RDA 101015 LT8<br/>
                        </address>
                      </td>
                      <td>
                          Para
                          <address>
                            <strong>'#{@current_cliente.user.name} #{@current_cliente.user.apellidoPaterno} #{@current_cliente.user.apellidoMaterno}'</strong><br>
                            Email: <a target='_top' href='mailto:#{@current_cliente.user.email}'>'#{@current_cliente.user.email}'</a></br>
                          </address>
                      </td>
                      <td>
                        <b>ID de autorización:</b> #{@response_hash['authorization']} <br/>
                        <b>Cuenta en OpenPay:</b> #{@current_cliente.user.name}</br>
                      </td>
                    </tr>
                  </table>
                  <table border='1' style='border-style: groove;'>
                    <thead>
                      <tr>
                        <th>Cantidad</th>
                        <th>Producto</th>
                        <th>Subtotal</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td align='center'>1</td>
                        <td align='center'>#{@response_hash['description']}</td>
                        <td align='center'>#{@response_hash['currency']} $#{(@response_hash['metadata'].to_hash)['subtotal']}</td>
                      </tr>
                      <tr>
                        <td colspan='2'>
                          <p class='lead'>Métodos de pago:</p>
                          <img src='http://104.236.6.99/assets/credit/visa.png' alt='Visa'/>
                          <img src='http://104.236.6.99/assets/credit/mastercard.png' alt='Mastercard'/>
                          <img src='http://104.236.6.99/assets/credit/american-express.png' alt='American Express'/>
                          <br>
                          <div>
                            <b>Nota:</b><br>
                            Tu cr&eacute;dito ya ha sido reflejado.<br>
                            Guarda este comprobante o impr&iacute;melo para futuras referencias.<br>
                          </div>
                        </td>
                        <td>
                          <table class='table'>
                            <tr>
                              <th style='width:50%' align='right'>Subtotal:</th>
                              <td>#{@response_hash['currency']} $#{(@response_hash['metadata'].to_hash)['subtotal']}</td>
                            </tr>
                            <tr>
                              <th style='width:50%' align='right'>Impuesto (#{(@response_hash['metadata'].to_hash)['iva']}%):</th>
                              <td>#{@response_hash['currency']} $#{(@response_hash['metadata'].to_hash)['impuesto']}</td>
                            </tr>
                            <tr>
                              <th style='width:50%' align='right'>Total:</th>
                              <td>#{@response_hash['currency']} $#{@response_hash['amount']}</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </tbody>
                  </table>"
      mail(to: @current_cliente.user.email,
           body: email_body,
           content_type: "text/html",
           subject: "Compra Vanpool - Recibo de Pago")

  end

  def enviar_correo_prueba
    puts DateTime.now.strftime('%d/%m/%Y- %T ===> ')
    mail(to: "alvaro9210@gmail.com",
         body: Configuracion.find(7).valor.gsub(/(@usuario)/i, Cliente.find(1).user.name),
         content_type: "text/html",
         subject: 'En Vanpool te extrañamos')
  end

end
# <!-- Danger box -->
#                 <div class='box box-solid box-success'>
# <div class='box-header'>
# <h3 class='box-title'>
# <i class='fa fa-fw fa-check'></i> Recarga realizada con éxito.
#                       </h3>
# <div class='box-tools pull-right'>
# </div>
#                     </div>
# <div class='box-body'>
# <div class='row-fluid'>
# <div class='span12'>
# <section class='content-header'>
# </section>
#                           <h2 class='page-header'>
#                             Redes de Aventones SAPI de CV.
#                             <small class='pull-right'>Fecha: <%= Date.parse(@response_hash['creation_date']).strftime('%d/%^b/%Y') %></small>
#                           </h2>
#                         </div><!-- /.col -->
#                       </div>
#                       <!-- info row -->
#                       <div class='row-fluid invoice-info'>
#                         <div class='span4 invoice-col'>
#                           De
#                           <address>
#                             <strong>Redes de Aventones SAPI de CV.</strong><br>
#                             Monte Cáucaso 993<br>
#                             Col. Lomas de Chapultepec<br>
#                             Del. Miguel Hidalgo, México<br>
#                             D.F., México, 11000<br>
#                             RFC: RDA 101015 LT8<br/>
#                           </address>
#                         </div><!-- /.col -->
#                         <div class='span4 invoice-col'>
#                           Para
#                           <address>
#                             <strong><%= '#{@current_cliente.user.name} #{@current_cliente.user.apellidoPaterno} #{@current_cliente.user.apellidoMaterno}' %></strong><br>
# Email: <a target='_top' href='mailto:<%= @current_cliente.user.email %>'><%= '#{@current_cliente.user.email}' %></a></br>
#                           </address>
#
#                         </div><!-- /.col -->
#                         <div class='span4 invoice-col'>
# <b>ID de autorización:</b> <%= @response_hash['authorization'] %><br/>
# <b>Cuenta en OpenPay:</b> <%= obtener_cliente(current_user).user.name %></br>
# </div><!-- /.col -->
# </div><!-- /.row -->
# <!-- Table row -->
#                <div class='row-fluid'>
# <div class='span12 table-responsive'>
# <table class='table table-striped'>
# <thead>
# <tr>
# <th>Cantidad</th>
#                               <th>Producto</th>
# <th>Subtotal</th>
#                             </tr>
# </thead>
#                             <tbody>
#                             <tr>
#                               <td>1</td>
# <td><%= @response_hash['description'] %></td>
#                               <td><%= @response_hash['currency'] %> $<%= (@response_hash['metadata'].to_hash)['subtotal'] %></td>
#                             </tr>
# </tbody>
#                           </table>
# </div><!-- /.col -->
# </div><!-- /.row -->
# <div class='row-fluid'>
# <!-- accepted payments column -->
#                               <div class='span6'>
# <p class='lead'>Métodos de pago:</p>
#                           <img src='/assets/credit/visa.png' alt='Visa'/>
#                           <img src='/assetscredit/mastercard.png' alt='Mastercard'/>
#                           <img src='/assets/credit/american-express.png' alt='American Express'/>
#                           <p class='text-muted well well-sm no-shadow' style='margin-top: 10px;'>
#                             <b>Nota:</b><br>
#                             Tu cr&eacute;dito ha ya ha sido reflejado.<br>
#                             Guarda este comprobante o impr&iacute;melo para futuras referencias.<br>
#                           </p>
#                         </div><!-- /.col -->
#                         <div class='span6'>
#
#                           <div class='table-responsive'>
#                             <table class='table'>
#                               <tr>
#                                 <th style='width:50%'>Subtotal:</th>
#                                 <td><%= @response_hash['currency'] %> $<%= (@response_hash['metadata'].to_hash)['subtotal'] %></td>
#                               </tr>
#                               <tr>
#                                 <th>Impuesto (<%= (@response_hash['metadata'].to_hash)['iva'] %>%):</th>
#                                 <td><%= @response_hash['currency'] %> $<%= (@response_hash['metadata'].to_hash)['impuesto'] %></td>
#                               </tr>
#                               <tr>
#                                 <th>Total:</th>
#                                 <td><%= @response_hash['currency'] %> $<%= @response_hash['amount'] %></td>
#                               </tr>
#                             </table>
#                           </div>
#                         </div><!-- /.col -->
#                       </div><!-- /.row -->
#                       <!-- this row will not appear when printing -->
#                       <div class='row-fluid no-print'>
#                         <div class='span12'>
#                           <button class='btn btn-default btn-flat pull-right' style='margin-right: 5px;' onclick='window.print();'><i class='fa fa-print'></i> Imprimir</button>
#                         </div>
#                       </div>
#                     </div><!-- /.box-body -->
#                   </div><!-- /.box -->