require "application_system_test_case"

class PunchiesTest < ApplicationSystemTestCase
  setup do
    @punchy = punchies(:one)
  end

  test "visiting the index" do
    visit punchies_url
    assert_selector "h1", text: "Punchies"
  end

  test "creating a Punchy" do
    visit punchies_url
    click_on "New Punchy"

    fill_in "Name", with: @punchy.name
    fill_in "Timepunchin", with: @punchy.timePunchIn
    fill_in "Timepunchout", with: @punchy.timePunchOut
    fill_in "User", with: @punchy.user_id
    click_on "Create Punchy"

    assert_text "Punchy was successfully created"
    click_on "Back"
  end

  test "updating a Punchy" do
    visit punchies_url
    click_on "Edit", match: :first

    fill_in "Name", with: @punchy.name
    fill_in "Timepunchin", with: @punchy.timePunchIn
    fill_in "Timepunchout", with: @punchy.timePunchOut
    fill_in "User", with: @punchy.user_id
    click_on "Update Punchy"

    assert_text "Punchy was successfully updated"
    click_on "Back"
  end

  test "destroying a Punchy" do
    visit punchies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Punchy was successfully destroyed"
  end
end
