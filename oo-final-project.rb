class Student
  attr_accessor :name, :hw_checklist, :checklist, :score, :lateness, :absences, :promotion

  def initialize(name) # creating an new student that take in the name of the student
    @name = name.gsub(/[@]/,"") # 
    @score = 75
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
    @subject = subject.gsub(/[@]/,"") 
    @name = name.gsub(/[@]/,"") 
    @hws_assigned = {}
  end

  def phone_call(student_name)
    if student_name.score < 65
      puts "I'm #{student_name.name}'s #{@subject} teacher. I just want to inform you that your child's great didn't meet the branchmark, and he should pay more attention in the dlass"
    elsif student_name.absences > 5 || student_name.lateness > 10
    puts "I'm #{student_name}'s #{@subject} teacher. I just want to inform you that your child's attendance seems to be a problem, is there anything that I can do to help?" 
    else
      puts "I'm #{student_name}'s #{@subject} teacher. I just want to inform you that your child is doing great in the class!"
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

# wei = Student.new("wei")
# wei.late("jan 1st")
# wei.late("feb 1st")
# wei.absence("july 5th")

# zheng = Student.new("Zheng")


# mueller = Teacher.new("Mr. Mueller", "sep")
# mueller.assign_work("sep", "oo_project", "@#{student}")
# mueller.assign_work("sep", "oo_project", zheng)


# terzano = Teacher.new("Mr. Terzano", "physics")
# terzano.assign_work("physics","page 101", wei)
# terzano.assign_work("physics","page 01", wei)
# terzano.assign_work("physics","page 101", zheng)
# terzano.assign_work("physics","page 01", zheng)

# terzano.phone_call(wei)
# mueller.phone_call(zheng)

# wei.doing_hw("physics", "page 101")
# wei.view_status
# zheng.view_status


def run 
  puts "What is your name?"
  student_name = "@" + gets.chomp!
  instance_variable_set student_name, Student.new(student_name)
  student = instance_variable_get student_name
  student.name


  puts "How many class do you have?"
  class_num = gets.chomp.to_i
  class_num.times {
    puts "Who is your teacher?"
    teacher_name = "@" + gets.chomp!
    puts "What subject does s/he teaches?"
    subject_des = "@" + gets.chomp!
    teacher = instance_variable_set teacher_name, Teacher.new(teacher_name, subject_des)
    puts "What HW did s/he assigned?"
    hw = gets.chomp
    teacher.assign_work(subject_des, hw, student)
  }



  loop do
    puts "What do you want to do?
    1. Import Lateness
    2. Import Absence
    3. View HW Checklist
    4. View Status
    5. Exit"
    # 3. Add HW to checklist
    user_input = gets.chomp
      if user_input == "1"
        puts "What date were you late?"
        user_late_date = gets.chomp
        student.late(user_late_date)
      elsif user_input == "2"
        puts "What date were you absent?"
        user_absence_date = gets.chomp
        student.absence(user_absence_date)
      # elsif user_input == "3"
      #   puts "Who assigned the HW?"

      elsif user_input == "3"
        puts student.view_checklist
  
      elsif user_input == "4"
        student.view_status
      end
    break if user_input == "5"
  end
end

run



