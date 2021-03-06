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

describe AdministradorsController do

  # This should return the minimal set of attributes required to create a valid
  # Administrador. As you add validations to Administrador, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdministradorsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all administradors as @administradors" do
      administrador = Administrador.create! valid_attributes
      get :index, {}, valid_session
      assigns(:administradors).should eq([administrador])
    end
  end

  describe "GET show" do
    it "assigns the requested administrador as @administrador" do
      administrador = Administrador.create! valid_attributes
      get :show, {:id => administrador.to_param}, valid_session
      assigns(:administrador).should eq(administrador)
    end
  end

  describe "GET new" do
    it "assigns a new administrador as @administrador" do
      get :new, {}, valid_session
      assigns(:administrador).should be_a_new(Administrador)
    end
  end

  describe "GET edit" do
    it "assigns the requested administrador as @administrador" do
      administrador = Administrador.create! valid_attributes
      get :edit, {:id => administrador.to_param}, valid_session
      assigns(:administrador).should eq(administrador)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Administrador" do
        expect {
          post :create, {:administrador => valid_attributes}, valid_session
        }.to change(Administrador, :count).by(1)
      end

      it "assigns a newly created administrador as @administrador" do
        post :create, {:administrador => valid_attributes}, valid_session
        assigns(:administrador).should be_a(Administrador)
        assigns(:administrador).should be_persisted
      end

      it "redirects to the created administrador" do
        post :create, {:administrador => valid_attributes}, valid_session
        response.should redirect_to(Administrador.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved administrador as @administrador" do
        # Trigger the behavior that occurs when invalid params are submitted
        Administrador.any_instance.stub(:save).and_return(false)
        post :create, {:administrador => {}}, valid_session
        assigns(:administrador).should be_a_new(Administrador)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Administrador.any_instance.stub(:save).and_return(false)
        post :create, {:administrador => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested administrador" do
        administrador = Administrador.create! valid_attributes
        # Assuming there are no other administradors in the database, this
        # specifies that the Administrador created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Administrador.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => administrador.to_param, :administrador => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested administrador as @administrador" do
        administrador = Administrador.create! valid_attributes
        put :update, {:id => administrador.to_param, :administrador => valid_attributes}, valid_session
        assigns(:administrador).should eq(administrador)
      end

      it "redirects to the administrador" do
        administrador = Administrador.create! valid_attributes
        put :update, {:id => administrador.to_param, :administrador => valid_attributes}, valid_session
        response.should redirect_to(administrador)
      end
    end

    describe "with invalid params" do
      it "assigns the administrador as @administrador" do
        administrador = Administrador.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Administrador.any_instance.stub(:save).and_return(false)
        put :update, {:id => administrador.to_param, :administrador => {}}, valid_session
        assigns(:administrador).should eq(administrador)
      end

      it "re-renders the 'edit' template" do
        administrador = Administrador.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Administrador.any_instance.stub(:save).and_return(false)
        put :update, {:id => administrador.to_param, :administrador => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested administrador" do
      administrador = Administrador.create! valid_attributes
      expect {
        delete :destroy, {:id => administrador.to_param}, valid_session
      }.to change(Administrador, :count).by(-1)
    end

    it "redirects to the administradors list" do
      administrador = Administrador.create! valid_attributes
      delete :destroy, {:id => administrador.to_param}, valid_session
      response.should redirect_to(administradors_url)
    end
  end

end
