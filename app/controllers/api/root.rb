module API
  class Root < Grape::API
    prefix 'api'
    error_formatter :json, API::ErrorFormatter

    mount API::V1::Root
    # mount API::V2::Root (next version)
  end
end
