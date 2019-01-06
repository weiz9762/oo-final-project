class Student
  attr_accessor :name, :checklist, :score, :lateness, :absence

  def initialize(name)
    @name = name.capitalize
    @score = 100
    @lateness = 0
    @absence = 0
    @absence_dates = []
    @late_dates = []
  end

  def late(date)
    @score -= 1
    @lateness += 1
    @late_dates << date.capitalize
  end

  def absence(date)
    @score -= 2
    @absence += 1
    @absence_dates << date.capitalize
  end

  def view_status
    puts "#{@name}:
    Grade: #{@score}.
    Total Latesness: #{@lateness} (#{@late_dates.join(", ")})
    Total Absences: #{@absence} (#{@absence_dates.join(", ")})"
  end

  # def view_checklist
  #   @checklist
  # end
end

wei = Student.new("wei")
wei.late("jan 1st")
wei.late("feb 1st")
wei.absence("july 5th")
wei.view_status
# class Teacher
#   attr_accessor :name, :subject, :hw

#   def initialize(subject, name)
#     @subject = subject
#     @name = name
#   end

#   def phone_call
# end