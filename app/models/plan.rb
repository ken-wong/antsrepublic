class Plan < ActiveRecord::Base
	belongs_to :need
	has_many :tasks

	validates :title, presence: true
	validates :dead_line, presence: true

	state_machine :state, :initial => :'open' do
    event :close! do
      transition [nil, :'open'] => :'closed'
    end

    event :reopen! do
    	transition [nil, :'closed'] => :'open'
    end
  end
end
