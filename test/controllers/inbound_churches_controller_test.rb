require 'test_helper'

class InboundChurchesControllerTest < ActionController::TestCase
  setup do
    @inbound_church = inbound_churches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inbound_churches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inbound_church" do
    assert_difference('InboundChurch.count') do
      post :create, inbound_church: { address: @inbound_church.address, city: @inbound_church.city, denomination: @inbound_church.denomination, description: @inbound_church.description, gmaps: @inbound_church.gmaps, latitude: @inbound_church.latitude, longitude: @inbound_church.longitude, name: @inbound_church.name, state: @inbound_church.state, zipCode: @inbound_church.zipCode }
    end

    assert_redirected_to inbound_church_path(assigns(:inbound_church))
  end

  test "should show inbound_church" do
    get :show, id: @inbound_church
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inbound_church
    assert_response :success
  end

  test "should update inbound_church" do
    patch :update, id: @inbound_church, inbound_church: { address: @inbound_church.address, city: @inbound_church.city, denomination: @inbound_church.denomination, description: @inbound_church.description, gmaps: @inbound_church.gmaps, latitude: @inbound_church.latitude, longitude: @inbound_church.longitude, name: @inbound_church.name, state: @inbound_church.state, zipCode: @inbound_church.zipCode }
    assert_redirected_to inbound_church_path(assigns(:inbound_church))
  end

  test "should destroy inbound_church" do
    assert_difference('InboundChurch.count', -1) do
      delete :destroy, id: @inbound_church
    end

    assert_redirected_to inbound_churches_path
  end
end
