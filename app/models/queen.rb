class Queen < User
	default_scope { with_role :queen }
	has_many :queen_works

	def vote_stars
		#todo sum vote stars
		0
	end
end
