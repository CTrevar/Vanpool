# encoding: UTF-8
class Configuracion < ActiveRecord::Base
  attr_accessible :nombre, :valor, :id

  validates :valor, presence: true
  validates :valor, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 60}, :unless => Proc.new {|c| c.id != 8}
  validates :valor, :numericality => {:greater_than_or_equal_to => 1}, :unless => Proc.new {|c| c.id != 2}
  validates :valor, :numericality => {:greater_than_or_equal_to => 1}, :unless => Proc.new {|c| c.id != 3}
  validates :valor, :numericality => {:greater_than_or_equal_to => 1}, :unless => Proc.new {|c| c.id != 1}
  # validate :validar_enteros

  private
    # def validar_enteros
    #   if :id == 8
    #     if !(:valor.is_a?(Numeric))
    #       errors.add(:valor, "- Debe ingresar solamente números")
    #     end
    #   end
    #   # errors.add(:valor, "- Debe ingresar solamente números") unless :valor.is_a?(Numeric) && :id == 8
    # end
end
