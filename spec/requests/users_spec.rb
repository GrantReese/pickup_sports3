require 'rails_helper'

RSpec.describe "Userss", type: :request do
  describe "GET /Users" do
  
    let(:user) {create(:user)}

    before do
    user
    get "/users"
    end

    it "returns a success response" do
      expect(response).to be_successful
    end

    it "returns a response with all the users" do
      expect(response.body).to eq(User.all.to_json)
    end
  end

  describe "GET /user/:id" do
    let(:user) {create(:user)}

    before do
      get "/users/#{user.id}"
    end

    it "returns a success response" do
      expect(response).to be_successful
    end

    it "returns a response with the correct user" do
      expect(response.body).to eq(user.to_json)
    end
  end
  
  #create
  describe "POST /users" do
    context "with valid params" do
     
      before do
        user_attributes = attributes_for(:user)
        post "/users", params: user_attributes
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

    end

    context "with invalid params" do
      
      before do
        user_attributes = attributes_for(:user, first_name: nil)
        post "/users", params: user_attributes
      end
      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end

    end

  end
  
  #update  
  describe "PUT /users/:id" do
    context "with valid params" do
      let(:user) {create(:user)}

      before do 
        user_attributes = {first_name: "John" }
        put "/users/#{user.id}", params: user_attributes
    end

    it "updates a user" do
      user.reload
      expect(user.content).to eq("John")
    end

    it "returns a success response" do
      expect(response).to be_successful
    end
  end

  context "with invalid params" do
    let(:user) {create(:user)}

    before do 
      post_attributes = {first_name: nil}
      put "users/#{user.id}", params: post_attributes
    end

    it "returns a response with errors" do
      expect(response.status).to eq(422)
    end
  end
end

#destroy
describe "DELETE /user/:id" do
  let (:user) {create(:user)}

  before do 
    delete "/users/#{user.id}"
  end

  it "deletes a user" do
    expect(Post.count). to eq(0)
  end

  it "returns success response" do
    expect(response).to be_successful
  end
end
end
