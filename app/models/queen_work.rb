class QueenWork < Product
 default_scope { where state: '我的案例'}
 belongs_to :queen
end
