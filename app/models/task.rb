class Task < ActiveRecord::Base
  belongs_to :need
  belongs_to :plan
  has_many :attachments, as: :attachmentable

  validates :title, presence: true
  validates :need_id, presence: true
  validates :plan_id, presence: true


  state_machine :state, :initial => :'提交附件' do
    event :wait_for! do
      transition [nil, :'提交附件', :'退回重来'] => :'等待甲方'
    end
    
    event :confirm! do
      transition [nil, :'等待甲方'] => :'甲方确认'
    end

    event :refuse! do
      transition [nil, :'等待甲方'] => :'退回重来'
    end

    event :redo! do
    	transition [nil, :'等待甲方', :'退回重来'] => :'提交附件'
    end
  end
end
