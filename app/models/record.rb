class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :recordable, polymorphic: true
end
