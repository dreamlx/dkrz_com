class Leader < ActiveRecord::Base
  belongs_to :user
  state_machine :state, :initial => nil do
    event :confirm do
      transition nil => :'通过'
    end
    event :deny do
      transition nil => :'未通过'
    end
  end
end
