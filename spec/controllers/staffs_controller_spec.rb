require 'spec_helper'
require "factories/factory"

describe StaffsController do
  before do
    @staff = FactoryGirl.create :staff
    sign_in @staff
  end
  after do
    Staff.last.destroy
  end
  describe "GET #show" do 
  	it "assigns the requested staff to @staff" do 
  		get :show, id: @staff 
  		assigns(:staff).should eq(@staff)
  	end 
  	it "renders the #show view" do 
  		get :show, id: @staff
  		response.should render_template :show 
  	end 
  end

  describe "GET new" do
  	it "render new teplate" do
  		get :new
  		response.should render_template :new
  	end
  end

  describe "GET edit" do
  	it "render edit teplate" do
  		get :edit, id: @staff
  		response.should render_template :edit
  	end
  end
end
