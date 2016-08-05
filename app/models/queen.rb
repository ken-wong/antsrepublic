class Queen < User
	default_scope { with_role :queen }
	has_many :queen_works
end
