# lib/api/v1/authors.rb
module API
  module V1
    class Clientes < Grape::API
      version 'v1'
      format :json

      resource :clientes do
        desc "Return list of clientes"
        get do
          Cliente.all
        end
      end
    end
  end
end
