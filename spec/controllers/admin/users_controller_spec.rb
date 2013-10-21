require 'spec_helper'
describe Admin::UsersController do
	let(:user) { FactoryGirl.create(:user) }
	context "standard users" do
		before { sign_in(user) }
		it "are not able to access the index action" do
			get 'index'
			expect(response).to redirect_to('/')
			expect(flash[:alert]).to eql("You must be an admin to do that.")
		end 
	end

	# it "cannot access the show action without permission" do
	#   project = FactoryGirl.create(:project)
	#   get :show, id: project.id
	#   expect(response).to redirect_to(projects_path)
	#   expect(flash[:alert]).to eql("The project you were looking " +
	# 								"for could not be found.")
	# end
end