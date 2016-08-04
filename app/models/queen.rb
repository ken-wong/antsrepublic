class Queen < User

	has_many :products
  acts_as_messageable  :required => :body
end
