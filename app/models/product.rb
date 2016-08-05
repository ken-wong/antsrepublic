class Product < ActiveRecord::Base

  belongs_to :user
  belongs_to :queen, class_name: "User"
  has_many :queen_product_relations
	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainMediaUploader

	validates :title, presence: true
	validates :category, presence: true

	has_many :uploads

  acts_as_taggable
  acts_as_follower
  acts_as_votable

  # :state, collection: ['等待审核', '审核拒绝', '指派蚁后', '项目开始', '项目终止', '项目完成', '我的案例'] 
  # todo, 改变状态发送消息
  state_machine :state, :initial => :'等待审核' do
    event :confirm! do
      transition [nil, :'等待审核'] => :'指派蚁后'
    end

    event :unconfirm! do
      transition [nil, :'等待审核'] => :'审核拒绝'
    end

    event :start! do
      transition [nil, :'指派蚁后'] => :'项目开始'
    end

    event :fail! do
      transition [nil, :'指派蚁后', :'项目开始',:'等待审核'] => :'项目终止'
    end

    event :redo! do
      transition [:'项目终止',:'审核拒绝'] => :'等待审核'
    end    

    event :close! do
      transition [:'项目开始'] => :'项目完成'
    end

    event :final! do
      transition [nil, :'等待审核', :'项目完成'] => :'我的案例'
    end
  end

  def send_message(admin, from, to)
    admin.send_message(user, "<a href=\"/products/#{id}\" >#{title}</a>从#{from}到#{to}") if user
    admin.send_message(queen, "<a href=\"/products/#{id}\" >#{title}</a>从#{from}到#{to}") if queen
  end
end
