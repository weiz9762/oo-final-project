class Student
  attr_accessor :name, :checklist, :score, :lateness, :absences, :promition

  def initialize(name)
    @name = name.capitalize
    @score = 100
    @lateness = 0
    @absences = 0
    @absence_dates = []
    @late_dates = []
    @promition = ""
  end

  def late(date)
    @score -= 1
    @lateness += 1
    @late_dates << date.capitalize
  end

  def absence(date)
    @score -= 2
    @absences += 1
    @absence_dates << date.capitalize
  end

  # def promotion_tracker(name)
  #   if name.absence < 30 && name.grade > 65
  #     @promotion = "on track"
  #   else
  #     @promotion = "off track"
  #   end
  # end

  def view_status
    puts "#{@name}:
    Grade: #{@score}.
    Total Latesness: #{@lateness} (#{@late_dates.join(", ")})
    Total Absences: #{@absences} (#{@absence_dates.join(", ")})
    **Promotion Tracker: #{@promotion}"
    
  end



  # def view_checklist
  #   @checklist
  # end
end

wei = Student.new("wei")
# wei.late("jan 1st")
# wei.late("feb 1st")
# wei.absence("july 5th")
# wei.view_status
class Teacher
  attr_accessor :name, :subject, :hw

  def initialize(subject, name)
    @subject = subject
    @name = name
  end

  def phone_call(student_name)
    if student_name.score < 65
      "need to work harder"
    elsif student_name.absences > 5 || student_name.lateness > 10
      "Need to come to class more"
    else
      "Great work"
    end

  end
  # def phone_call

  # end
end

terzano = Teacher.new("physics", "terzano")
terzano.phone_call(wei)