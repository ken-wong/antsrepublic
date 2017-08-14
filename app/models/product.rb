class Product < ActiveRecord::Base

  belongs_to :user
  belongs_to :queen, class_name: "User"


	mount_uploader :avatar, AvatarUploader
	mount_uploader :main_media, MainMediaUploader

	validates :title, presence: true
	validates :category, presence: true
	has_many :uploads

  acts_as_taggable
  acts_as_followable
  acts_as_votable
  acts_as_paranoid

  # :state, collection: ['等待审核', '审核拒绝', '寻找蚁后', '提交计划', '项目终止', '项目完成', '我的案例']
  # todo, 改变状态发送消息
  state_machine :state, :initial => :'等待审核' do
    event :confirm! do
      transition [nil, :'等待审核'] => :'寻找蚁后'
    end

    event :unconfirm! do
      transition [nil, :'等待审核'] => :'审核拒绝'
    end

    event :start! do
      transition [nil, :'等待审核' , :'寻找蚁后', :'提交计划'] => :'提交计划'
    end

    event :waitfor! do
      transition [:'提交计划', :'甲方拒绝'] => :'等待甲方'
    end

    event :plan_refuse! do
      transition [:'等待甲方'] => :'甲方拒绝'
    end

    event :plan_confirm! do
      transition [:'等待甲方'] => :'乙方执行'
    end

    event :fail! do
      transition [nil, :'寻找蚁后', :'提交计划',:'等待审核',:'乙方执行', :'等待甲方' ] => :'项目终止'
    end

    event :redo! do
      transition [:'项目终止',:'审核拒绝'] => :'等待审核'
    end

    event :close! do
      # newline
      transition [:'乙方执行'] => :'项目完成'
    end

    event :final! do
      transition [nil, :'等待审核', :'项目完成'] => :'我的案例'
    end
  end

  def send_message(admin, from, to)
    return
    if user
      admin.send_message(user, "<a href=\"/products/#{id}\" >#{title}</a>从#{from}到#{to}")
    end
    if queen
      admin.send_message(queen, "<a href=\"/products/#{id}\" >#{title}</a>从#{from}到#{to}")
    end
  end

  def is_my?(user_id)
    user_id == self.queen_id ? true : false
  end
end
