class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || I18n.t("not_email")) unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class User < ActiveRecord::Base
  validates :openid, presence: true, uniqueness: true
  # validates :number, length: { is: 6 } # validation is called before before_create ...
  validates :cell, length: { minimum: 11 }
  validates :email, presence: true, email: true

  has_many :feedbacks, dependent: :destroy
  has_many :leaders

  before_create :generate_number

  mount_uploader :avatar, AvatarUploader
  
  private
    def generate_number
      self.number = loop do
        random_number = rand(100000..999999).to_s
        break random_number unless self.class.exists?(number: random_number)
      end
    end
end
