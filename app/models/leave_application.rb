class LeaveApplication < ApplicationRecord
  belongs_to :user 
  validates_presence_of :leave_date
  validates_uniqueness_of :leave_date

end
