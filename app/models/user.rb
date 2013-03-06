class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :credit_card
  # attr_accessible :title, :body
  #

  has_many :orders

  attr_accessor :credit_card

  validate do
    if need_credit_card? and credit_card.invalid?
      errors.add :credit_card_id, "Validation error"
    end
  end

  before_save :create_credit_card, :if => :need_credit_card?

  def need_credit_card?
    # credit_card_id.nil? or credit_card.present?
    credit_card.present?
  end

  def create_credit_card
    credit_card.payer_id = self.email
    if credit_card.create
      self.credit_card_id          = credit_card.id
      self.credit_card_description = credit_card.description
      true
    else
      errors.add :credit_card_id, "Validation error"
      false
    end
  end

  def fetch_credit_card
    @fetch_credit_card ||= credit_card_id && CreditCard.find(credit_card_id)
  end

  def credit_card
    @credit_card ||= CreditCard.new
  end

  def credit_card=(hash)
    @credit_card = CreditCard.new(hash)
  end

end
