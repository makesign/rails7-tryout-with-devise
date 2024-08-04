require "application_system_test_case"

class GeheimsTest < ApplicationSystemTestCase
  setup do
    @geheim = geheims(:one)
  end

  test "visiting the index" do
    skip
    visit geheims_url
    assert_selector "h1", text: "Geheims"
  end

  test "should create geheim" do
    skip
    visit geheims_url
    click_on "New geheim"

    fill_in "Content", with: @geheim.content
    fill_in "Title", with: @geheim.title
    click_on "Create Geheim"

    assert_text "Geheim was successfully created"
    click_on "Back"
  end

  test "should update Geheim" do
    skip
    visit geheim_url(@geheim)
    click_on "Edit this geheim", match: :first

    fill_in "Content", with: @geheim.content
    fill_in "Title", with: @geheim.title
    click_on "Update Geheim"

    assert_text "Geheim was successfully updated"
    click_on "Back"
  end

  test "should destroy Geheim" do
    skip
    visit geheim_url(@geheim)
    click_on "Destroy this geheim", match: :first

    assert_text "Geheim was successfully destroyed"
  end
end
