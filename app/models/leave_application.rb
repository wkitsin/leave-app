class LeaveApplication < ApplicationRecord
  belongs_to :user
  validates_presence_of :leave_date
  before_create :check_applied_dates
  before_save :rearrange_dates, :check_for_past_dates
  before_save :leave_calculation, if: :leave_date_changed?
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

  def leave_calculation
    applied_leave = leave_date.count(',') + 1
    balance = user.balace
    if balance - applied_leave < 0
      errors.add(:leave_date, "The Annual Leave Application was not allowed because you do not have any remaining annual leave to spare")
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

  def approve_leave(approval, employee)
    if approval == 'approve'
      self.update(approved: 'Approved :)')

      # check of half day or full day
      self.half_or_full_day
      return true
    else
      self.update(approved: 'Not Approved')
      return false
    end
  end

  def half_or_full_day
    total_days = leave_date.count(',')
    if category == 'Annual Leave'
      total_days = total_days + 1
    elsif category[0..3] == 'Half'
      total_days = total_days + 0.5
    end
    leave_taken = user.leave_taken.to_f + total_days
    user.update(leave_taken: leave_taken)
  end



end
