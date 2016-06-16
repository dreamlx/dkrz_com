class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || I18n.t("not_email")) unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class User < ActiveRecord::Base
  validates :openid, presence: true, uniqueness: true
  # validates :number, length: { is: 6 } # validation is called before before_create ...
  validates :cell, length: { minimum: 11 }, allow_blank: true
  validates :email, presence: true, email: true, allow_blank: true

  has_many :feedbacks, dependent: :destroy
  has_many :leaders, dependent: :destroy
  has_many :records, dependent: :destroy
  belongs_to :superior, class_name: 'User'
  has_many :subordinates, class_name: 'User', foreign_key: "superior_id"

  before_create :generate_number

  mount_uploader :avatar, AvatarUploader
  mount_uploader :qrcode, QrcodeUploader
  
  private
    def generate_number
      self.number = loop do
        random_number = rand(100000..999999).to_s
        break random_number unless self.class.exists?(number: random_number)
      end
      qr = RQRCode::QRCode.new("http://pingan.dkrz.com/form?sub=006&number=#{self.number}")
      self.qrcode = open(qr.as_png.save("tmp/cache/#{self.number}.png"))
    end
end
