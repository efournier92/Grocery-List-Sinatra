require "spec_helper"

feature "user adds grocery list item" do
  scenario "item added when filled form submitted" do
    visit "/groceries"

    fill_in "Name", with: "coke zero"
    click_on "Add"

    expect(page).to have_content("coke zero")
  end

  scenario "empty li element is not added when form missing name is submitted" do
    visit "/groceries"
    click_on "Add"

    expect(page).not_to have_selector("li")
  end

  scenario "user adds grocery list item with quantity" do
    visit "/groceries"

    fill_in "Name", with: "coke zero"
    fill_in "Quantity", with: "3"
    click_on "Add"

    expect(page).to have_content("coke zero")
    expect(page).to have_content("3")
  end

  scenario "If only quantity is submitted, no grocery item is added" do
    visit "/groceries"

    fill_in "Quantity", with: "5"
    click_on "Add"

    expect(page).not_to have_selector("li")
  end

  scenario "Page is re-rendered with the previously submitted quantity pre-filled in the form" do
    visit "/groceries"

    fill_in "Name", with: "coke zero"
    fill_in "Quantity", with: "5"
    click_on "Add"

    expect(page).to have_selector("input[value='5']")
  end

  scenario "Each Item Name be a Link to Unique Page" do
    visit "/groceries"

    fill_in "Name", with: "coke"
    fill_in "Quantity", with: "5"
    click_on "Add"

    expect(page).to have_link('coke (5)', href: "/groceries/coke")
  end

  scenario "Each Item Name be a Link to Unique Page" do
    visit "/groceries"

    fill_in "Name", with: "coke"
    fill_in "Quantity", with: "5"
    click_on "Add"

    visit "/groceries/coke"

    expect(page).to have_content("coke")
    expect(page).to have_content("5")
  end

end
