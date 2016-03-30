class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :product

  aasm do
    state :payment, :initial => true
    state :cancel
    state :processing
    state :shipped
    state :complete

    event :paid do
      transitions :from => :payment, :to => :processing
    end

    event :shipped do
      transitions :from => :processing, :to => :shipped
    end

    event :complete do
      transitions :from => :shipped, :to => :complete
    end

    event :cancel do
      transitions :from => :payment, :to => :cancel
    end
  end
end
