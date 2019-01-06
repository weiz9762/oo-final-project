class Student
  attr_accessor :name, :hw_checklist, :checklist, :score, :lateness, :absences, :promotion

  def initialize(name)
    @name = name.capitalize
    @score = 65
    @lateness = 0
    @absences = 0
    @absence_dates = []
    @late_dates = []
    @promotion = ""
    @checklist = {}
  end

  def late(date)
    @score -= 3
    @lateness += 1
    @late_dates << date.capitalize
  end

  def absence(date)
    @score -= 5
    @absences += 1
    @absence_dates << date.capitalize
  end

  def view_checklist
    if @checklist == {}
      "NONE"
    else
      @checklist.collect { |k,v| "#{k}: #{v}" }.join(", ")
    end
  end
  
  def promotion_tracker
    if self.absences < 30 && self.score > 65
      @promotion = "on track"
    else
      @promotion = "off track"
    end
    @promotion
  end

  def doing_hw(subject, hw)
    self.checklist[subject].delete(hw)
    if self.checklist[subject] == []
      self.checklist.delete(subject)
      self.score += 5
    end
    self.score += 1
  end

  def view_status
    puts "#{self.name}:
    Grade: #{self.score}.
    HW Checklist: #{self.view_checklist}
    Total Latesness: #{@lateness} (#{@late_dates.join(", ")})
    Total Absences: #{@absences} (#{@absence_dates.join(", ")})
    Promotion Tracker: #{self.promotion_tracker}"
  end

end


class Teacher
  attr_accessor :name, :subject, :hw

  def initialize(name, subject)
    @subject = subject
    @name = name
    @hws_assigned = {}
  end

  def phone_call(student_name)
    if student_name.score < 65
      puts "I'm #{student_name.name}'#{@subject} teacher. I just want to inform you that your child's great didn't meet the branchmark, and he should pay more attention in the dlass"
    elsif student_name.absences > 5 || student_name.lateness > 10
    puts "I'm #{student_name}'#{@subject} teacher. I just want to inform you that your child's attendance seems to be a problem, is there anything that I can do to help?" 
    else
      puts "Great work"
    end
  end

  def assign_work(subject, hw, student)
    # student.checklist[subject] = hw
    if student.checklist[subject] == nil
      student.checklist[subject] = []
      student.checklist[subject] << hw
    else
      student.checklist[subject] << hw
    end
  end
end

wei = Student.new("wei")
wei.late("jan 1st")
wei.late("feb 1st")
wei.absence("july 5th")

zheng = Student.new("Zheng")


mueller = Teacher.new("Mr. Mueller", "sep")
mueller.assign_work("sep", "oo_project", wei)
mueller.assign_work("sep", "oo_project", zheng)


terzano = Teacher.new("Mr. Terzano", "physics")
terzano.assign_work("physics","page 101", wei)
terzano.assign_work("physics","page 01", wei)
terzano.assign_work("physics","page 101", zheng)
terzano.assign_work("physics","page 01", zheng)

terzano.phone_call(wei)
mueller.phone_call(zheng)

wei.doing_hw("physics", "page 101")
wei.view_status
zheng.view_status

# puts "What is your name"
# user_name = gets.chomp
# Student.new(user_name)
# puts "How many class do you have?"
# class_num = gets.chomp.to_i
# class_num.times {
#   puts "Who is your teacher?"
#   user_teacher = gets.chomp
#   Teacher.new(user_teacher)
# }