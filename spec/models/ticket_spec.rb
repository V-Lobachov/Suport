require 'spec_helper'

describe Ticket do
	describe ".search" do
		before do
			Ticket.create(name: 'Alan',
			 email: 'olo123@gmail.com', issue: 'Error', body: 'qwe', status: 'Completed')
			Ticket.create(name: 'Jon',
			 email: 'cor173@gmail.com', issue: 'Tail', body: 'qwe', status: 'Canceled')
			Ticket.create(name: 'Erik',
			 email: 'sas173@gmail.com', issue: 'Tail', body: 'qwe', status: 'On hold')			
			Ticket.create(name: 'Adam',
			 email: 'qwe273@gmail.com', issue: 'Tail', body: 'qwe', status: 'Waiting for staff Response')
		end
		it "should return all records" do
			tickets = Ticket.search ''
			expect(tickets).to eq(Ticket.all)
		end

		it "should return Completed records" do
			tickets = Ticket.search 'Completed'
			expect(tickets).to eq(Ticket.where(status: 'Completed'))
		end
		it "should return Canceled records" do
			tickets = Ticket.search 'Canceled'
			expect(tickets).to eq(Ticket.where(status: 'Canceled'))
		end

		it "should return On hold records" do
			tickets = Ticket.search 'On hold'
			expect(tickets).to eq(Ticket.where(status: 'On hold'))
		end


		it "should return Open records" do
			tickets = Ticket.search 'Waiting'
			expect(tickets).to eq(Ticket.find(:all, conditions: ['status LIKE ?','%Waiting%']))
		end
	end

	describe ".generate_reference" do
		it "should match with format" do
			expect(Ticket.generate_reference).to match(/([A-Z]{3})-([\d]{3})-([A-Z]{3})-([\d]{3})-([A-Z]{3})/)
		end
	end
end
