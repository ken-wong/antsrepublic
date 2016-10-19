class Need < Product
	default_scope { where( "state not like '我的案例'")}
	acts_as_commentable
	acts_as_votable
  has_many :tasks
  has_many :plans
end
