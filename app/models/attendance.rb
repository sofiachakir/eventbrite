class Attendance < ApplicationRecord
  after_create :new_participant_send
  belongs_to :event
  belongs_to :user

  def new_participant_send
    UserMailer.new_participant_email(self.event.admin).deliver_now
  end
end
