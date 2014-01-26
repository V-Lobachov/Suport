require 'spec_helper'
require "factories/factory"


describe TicketsController do

let!(:tickets){Array.new(2) { FactoryGirl.create :ticket } }
  describe "GET index" do
    it "select all tickets" do	  
  		get :index
  		expect(assigns(:tickets)).to eq(tickets)
  	end

  	it "render index for staff" do	
      @staff = FactoryGirl.create :staff
      sign_in @staff
  		get :index
      response.should render_template("index")
      Staff.last.destroy
  	end

    it "render welcome for users" do  
      get :index
      response.should render_template("welcome")
    end
  end

 describe "GET show" do
    it "get hotel" do
      ticket = tickets.first
      get :show, id: ticket
      expect(assigns(:ticket)).to eq(ticket)
    end
    it "render :show tempate" do
      get :show, id: tickets.first
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "render :new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    it "should assign @document to the document" do
        ticket = tickets.first
        get :edit, id: ticket
        assigns(:ticket).should eq(ticket)
      end
    it "render :edit template" do
      get :edit, id: tickets.first
      expect(response).to render_template("edit")
    end
  end
end