class PagosController < ApplicationController
	before_filter :signed_in_user, only: [:recarga]
end