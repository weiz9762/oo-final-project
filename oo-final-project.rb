class Student
  attr_accessor :name, :hw_checklist, :checklist, :score, :lateness, :absences, :promotion

  def initialize(name) # creating an new student that take in the name of the student
    @name = name.gsub(/[@]/,"") # student's name will be the paramter taken. Use gsub to remove the @(instance variable sign) when outputting the name (line 125)
    @score = 75 # student start with score of 75 (easy for the experiment)
    @lateness = 0
    @absences = 0
    @absence_dates = [] # empty array where the dates will be later push into
    @late_dates = []
    @promotion = ""
    @checklist = {} # hw checklist that set up as key-value pair (subject-hw)
  end

  def late(date) #take in date of late
    @score -= 3 # minus 3 pt for each absent
    @lateness += 1 # add total late by 1
    @late_dates << date.capitalize # insert the dates into the arr with it capitalized
  end

  def absence(date) #similar with late method
    @score -= 5
    @absences += 1
    @absence_dates << date.capitalize
  end

  def view_checklist 
    if @checklist == {} # if there is no hw in the hash, then return none
      "NONE"
    else
      @checklist.collect { |k,v| "#{k}: #{v}" }.join(", ") # if there is item in the hash, it will iterate through the hash, and output the subject : hw as string
    end
  end
  
  def promotion_tracker
    if self.absences < 30 && self.score > 65 # if student has less than 30 absences and higher grade than 65 it will return on track
      @promotion = "on track"
    else
      @promotion = "off track"
    end
    @promotion
  end

  def doing_hw(subject, hw) # taking in subject and hw name
    self.checklist[subject].delete(hw) # delete that specific hw vaklue from specific subject key
    if self.checklist[subject] == [] # if there is no value in the key, the key will will be then removed
      self.checklist.delete(subject)
      self.score += 5 # student gains 5 bouns pt for finishing the hw
    end
    self.score += 1 # whenever student completed hw, gain 1 extra point
  end

  def view_status # puts out the summary of student 
    puts "#{self.name}:
    Grade: #{self.score}.
    HW Checklist: #{self.view_checklist}
    Total Latesness: #{@lateness} (#{@late_dates.join(", ")}) 
    Total Absences: #{@absences} (#{@absence_dates.join(", ")})
    Promotion Tracker: #{self.promotion_tracker}"
    # dates will be display as a string instead of array with join method
  end

end


class Teacher
  attr_accessor :name, :subject, :hw

  def initialize(name, subject) #each teacher initialize with name and subj
    @subject = subject.gsub(/[@]/,"") 
    @name = name.gsub(/[@]/,"") 
    # @hws_assigned = {} # able to track hw s/he assigned (not complete)
  end

  def phone_call(student_name) # make phone call to student, response vary from different requirement
    if student_name.score < 65 
      puts "I'm #{student_name.name}'s #{@subject} teacher. I just want to inform you that your child's great didn't meet the branchmark, and he should pay more attention in the dlass"
    elsif student_name.absences > 5 || student_name.lateness > 10
    puts "I'm #{student_name}'s #{@subject} teacher. I just want to inform you that your child's attendance seems to be a problem, is there anything that I can do to help?" 
    else
      puts "I'm #{student_name}'s #{@subject} teacher. I just want to inform you that your child is doing great in the class!"
    end
  end

  def assign_work(subject, hw, student) # assign hw to student with subject and hw description
  # **** the subject parameter is extrea since teacher was initialized with subject ** next step
    # student.checklist[subject] = hw
    if student.checklist[subject] == nil # create new key if the subject is not exist
      student.checklist[subject] = [] 
      student.checklist[subject] << hw # insert hw into the subject key as an value
    else
      student.checklist[subject] << hw
    end
  end
end

# test 
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
  student_name = "@" + gets.chomp! # take in the user_input, and add @ before it to make a dynamic variable according to user's name
  instance_variable_set student_name, Student.new(student_name) # the dynamic var then will be set to an new student
  student = instance_variable_get student_name # set up a new variable (placeholder) for student info, else the program will think student_name as a string (line 125)



  puts "How many class do you have?"
  class_num = gets.chomp.to_i # will repeat for number of times according to how many class a student have
  class_num.times {
    puts "Who is your teacher?"
    teacher_name = "@" + gets.chomp!
    puts "What subject does s/he teaches?"
    subject_des = "@" + gets.chomp!
    teacher = instance_variable_set teacher_name, Teacher.new(teacher_name, subject_des)
    puts "What HW did s/he assigned?"
    hw = gets.chomp # similar to line 127 -127
    teacher.assign_work(subject_des, hw, student) # assigned works will then push into student's hw checklist
  }



  loop do #interactive, give user options, will loop until user choose 5 (exit)
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
        student.late(user_late_date) # late dates will be push to the student's info
      elsif user_input == "2"
        puts "What date were you absent?"
        user_absence_date = gets.chomp
        student.absence(user_absence_date)
      # elsif user_input == "3"
      #   puts "Who assigned the HW?"
      # *** next step, for student to add hw to their checklist

      elsif user_input == "3"
        puts student.view_checklist
      elsif user_input == "4"
        student.view_status
      end
    break if user_input == "5"
  end
end

run



