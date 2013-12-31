require 'spec_helper'

describe LocationsController do
  def valid_attributes
    {:address => "2510 W. Iowa St. Chicago, IL 60622"}
  end

  def valid_session
    {:format => :json}
  end

  describe "GET index" do
    it "renders the index template" do
      get :index, {}, valid_session
      response.should render_template('index')
    end

    it "responds with the list of locations in JSON" do
      location = Location.create! valid_attributes
      get_json :index, {}, valid_session

      expect(json_response).to have(1).location

      location_json = json_response.first
      puts location_json.inspect
      expect(location_json[:id]).to eq(location.id)
      expect(location_json[:address]).to eq(location.address)
    end
  end

  describe "GET show" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}, valid_session
      assigns(:location).should eq(location)
    end

    it "responds with the location in JSON" do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}, valid_session

      expect(json_body[:id]).to eq(location.id)
      expect(json_body[:address]).to eq(location.address)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Location" do
        expect {
          post_json :create, {:location => valid_attributes}, valid_session
        }.to change(Location, :count).by(1)
      end

      it "assigns a newly created location as @location" do
        post_json :create, {:location => valid_attributes}, valid_session
        assigns(:location).should be_a(Location)
        assigns(:location).should be_persisted
      end

      it "responds with the updated location" do
        post_json :create, {:location => valid_attributes}, valid_session
        expect(json_response[:address]).to eq(valid_attributes[:address])
        response.should be_success
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved location as @location" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post_json :create, {:location => {}}, valid_session
        assigns(:location).should be_a_new(Location)
      end

      it "returns an unprocessable_entity response" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post_json :create, {:location => {}}, valid_session
        response.code.should == "422"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested location" do
        location = Location.create! valid_attributes
        # Assuming there are no other locations in the database, this
        # specifies that the Location created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Location.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_json :update, {:id => location.to_param, :location => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested location as @location" do
        location = Location.create! valid_attributes
        put_json :update, {:id => location.to_param, :location => valid_attributes}, valid_session
        assigns(:location).should eq(location)
      end

      it "responds with success" do
        location = Location.create! valid_attributes
        put_json :update, {:id => location.to_param, :location => valid_attributes}, valid_session
        response.should be_success
      end
    end

    describe "with invalid params" do
      it "assigns the location as @location" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put_json :update, {:id => location.to_param, :location => {}}, valid_session
        assigns(:location).should eq(location)
      end

      it "returns an unprocessable_entity response" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put_json :update, {:id => location.to_param, :location => {}}, valid_session
        response.code.should == "422"
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes
      expect {
        delete_json :destroy, {:id => location.to_param}, valid_session
      }.to change(Location, :count).by(-1)
    end

    it "responds with success" do
      location = Location.create! valid_attributes
      delete_json :destroy, {:id => location.to_param}, valid_session
      response.should be_success
    end
  end

end
