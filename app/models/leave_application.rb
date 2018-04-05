class LeaveApplication < ApplicationRecord
  belongs_to :user
  validates_presence_of :leave_date
  before_create :check_applied_dates
  before_save :rearrange_dates, :check_for_past_dates
  before_destroy :check_for_past_dates

  def check_applied_dates
    @leave_array = LeaveApplication.where(id: 0)
    leave_date.split(',').each do |i|
      @leave_array = @leave_array.or(LeaveApplication.where(user_id: user_id).where("leave_date LIKE (?)",
      "%#{i}%"))
    end
    if @leave_array.length != 0
      errors.add(:leave_date, 'the date has already been taken' )
      throw :abort
    end
  end

  def rearrange_dates
    rearrage = leave_date.insert(0, ' ').split(',').sort.join(',')
    self.leave_date = rearrage
  end

  def check_for_past_dates
    current_leave_date = self.leave_date.split(',')[0].to_datetime

    if current_leave_date < Time.now
      errors.add(:leave_date, 'the date of leave has already begun')
      throw :abort
    end
  end

end
