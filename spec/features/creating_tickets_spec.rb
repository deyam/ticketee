require 'spec_helper'
feature "Creating Tickets" do
#  before do
#    FactoryGirl.create(:project, name: "Internet Explorer")
#    visit '/'
#    click_link "Internet Explorer"
#    click_link "New Ticket"
#  end

  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", project)
    define_permission!(user, "create tickets" , project)
    @email = user.email  # Why did we add this if the test already passed...14102013
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link "New Ticket"
#    message = "You need to sign in or sign up before continuing."
#    expect(page).to have_content(message)
#    fill_in "User Name", with: user.name
#    fill_in "Password", with: user.password
#    click_button "Sign in"
#    visit '/'
#    click_link project.name
#    click_link "New Ticket"
#    within("h2") { expect(page).to have_content("New Ticket") }
 #   expect(page).to have_content("New Ticket")
  end


  scenario "Creating a ticket" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"
    expect(page).to have_content("Ticket has been created.")
    within "#ticket #author" do
#    expect(page).to have_content("Created by sample@example.com")
    expect(page).to have_content("Created by #{@email}")
end
  end
  scenario "Creating a ticket without valid attributes fails" do
    click_button "Create Ticket"
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "it sucks"
    click_button "Create Ticket"  
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end