class Owner < User
	default_scope { with_role :owner }
	has_many :needs
end
