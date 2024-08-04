require "test_helper"

class GeheimsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @geheim = geheims(:one)
    @user = users(:one)
    sign_in(@user)
  end

  test "should get index" do
    get geheims_url
    assert_response :success
  end

  test "should get new" do
    get new_geheim_url
    assert_response :success
  end

  test "should create geheim" do
    assert_difference("Geheim.count") do
      post geheims_url, params: { geheim: { content: @geheim.content, title: @geheim.title } }
    end

    assert_redirected_to geheim_url(Geheim.last)
  end

  test "should show geheim" do
    get geheim_url(@geheim)
    assert_response :success
  end

  test "should get edit" do
    get edit_geheim_url(@geheim)
    assert_response :success
  end

  test "should update geheim" do
    patch geheim_url(@geheim), params: { geheim: { content: @geheim.content, title: @geheim.title } }
    assert_redirected_to geheim_url(@geheim)
  end

  test "should destroy geheim" do
    assert_difference("Geheim.count", -1) do
      delete geheim_url(@geheim)
    end

    assert_redirected_to geheims_url
  end
end
