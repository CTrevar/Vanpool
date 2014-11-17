# lib/api/v1/root.rb
module API
  module V1
    class Root < Grape::API
      mount API::V1::Rutas
      mount API::V1::Clientes
    end
  end
end
