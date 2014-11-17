# lib/api/v1/posts.rb
module API
  module V1
    class Rutas < Grape::API
      version 'v1'
      format :json

      resource :rutas do
        desc "Return list of rutas"
        get do
          Ruta.all
        end
      end
    end
  end
end
