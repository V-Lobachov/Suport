class Ticket < ActiveRecord::Base
belongs_to :stuff
validates :name, :email, :issue, :body, presence: true
validates :email, format: { with: /^[^\d\s]+[\d]+@[A-z]+\.[A-z]{2,4}/,multiline: true, on: :create}
	def self.search(search)
 		if search 
  	  		find(:all, :conditions => ['reference LIKE ? OR issue LIKE ? OR body LIKE ? OR status LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])

    	else 
    		find(:all)
    		#find(:all, :conditions =>['status LIKE ?',"%#{status}%"])
  		end

  

	end

	def self.generate_reference
		reference = []
		5.times do |x|
			if x%2==0
				reference<<rand_chr
			else
				reference<<rand_num
			end
		end
		reference.join('-')
	end
end

	def rand_chr
		(0..2).map{(65+rand(26)).chr}.join
	end
	def rand_num
		(0..2).map{(rand(10))}.join
	end