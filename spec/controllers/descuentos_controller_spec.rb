require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe DescuentosController do

  # This should return the minimal set of attributes required to create a valid
  # Descuento. As you add validations to Descuento, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DescuentosController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all descuentos as @descuentos" do
      descuento = Descuento.create! valid_attributes
      get :index, {}, valid_session
      assigns(:descuentos).should eq([descuento])
    end
  end

  describe "GET show" do
    it "assigns the requested descuento as @descuento" do
      descuento = Descuento.create! valid_attributes
      get :show, {:id => descuento.to_param}, valid_session
      assigns(:descuento).should eq(descuento)
    end
  end

  describe "GET new" do
    it "assigns a new descuento as @descuento" do
      get :new, {}, valid_session
      assigns(:descuento).should be_a_new(Descuento)
    end
  end

  describe "GET edit" do
    it "assigns the requested descuento as @descuento" do
      descuento = Descuento.create! valid_attributes
      get :edit, {:id => descuento.to_param}, valid_session
      assigns(:descuento).should eq(descuento)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Descuento" do
        expect {
          post :create, {:descuento => valid_attributes}, valid_session
        }.to change(Descuento, :count).by(1)
      end

      it "assigns a newly created descuento as @descuento" do
        post :create, {:descuento => valid_attributes}, valid_session
        assigns(:descuento).should be_a(Descuento)
        assigns(:descuento).should be_persisted
      end

      it "redirects to the created descuento" do
        post :create, {:descuento => valid_attributes}, valid_session
        response.should redirect_to(Descuento.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved descuento as @descuento" do
        # Trigger the behavior that occurs when invalid params are submitted
        Descuento.any_instance.stub(:save).and_return(false)
        post :create, {:descuento => {}}, valid_session
        assigns(:descuento).should be_a_new(Descuento)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Descuento.any_instance.stub(:save).and_return(false)
        post :create, {:descuento => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested descuento" do
        descuento = Descuento.create! valid_attributes
        # Assuming there are no other descuentos in the database, this
        # specifies that the Descuento created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Descuento.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => descuento.to_param, :descuento => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested descuento as @descuento" do
        descuento = Descuento.create! valid_attributes
        put :update, {:id => descuento.to_param, :descuento => valid_attributes}, valid_session
        assigns(:descuento).should eq(descuento)
      end

      it "redirects to the descuento" do
        descuento = Descuento.create! valid_attributes
        put :update, {:id => descuento.to_param, :descuento => valid_attributes}, valid_session
        response.should redirect_to(descuento)
      end
    end

    describe "with invalid params" do
      it "assigns the descuento as @descuento" do
        descuento = Descuento.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Descuento.any_instance.stub(:save).and_return(false)
        put :update, {:id => descuento.to_param, :descuento => {}}, valid_session
        assigns(:descuento).should eq(descuento)
      end

      it "re-renders the 'edit' template" do
        descuento = Descuento.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Descuento.any_instance.stub(:save).and_return(false)
        put :update, {:id => descuento.to_param, :descuento => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested descuento" do
      descuento = Descuento.create! valid_attributes
      expect {
        delete :destroy, {:id => descuento.to_param}, valid_session
      }.to change(Descuento, :count).by(-1)
    end

    it "redirects to the descuentos list" do
      descuento = Descuento.create! valid_attributes
      delete :destroy, {:id => descuento.to_param}, valid_session
      response.should redirect_to(descuentos_url)
    end
  end

end
