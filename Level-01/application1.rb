 require_relative './department1' # Include other files in the same directory

# Your application
class Application
   attr_accessor :departments

  def initialize
     self.departments=[]
     #self.departments = ['EEE', 'MECH', 'CSE', 'CIVIL'].each { |dept| Department.new(dept) }
     ['EEE', 'MECH', 'CSE', 'CIVIL'].each do |dept| 
      self.departments<<Department.new(dept) 
    end
  end

  def show
    self.departments.each do |dept|
      dept.show
    end
  end

  def enroll(student_name, student_department)
     department = self.departments.detect { |dept| dept.get_name == student_department}
     section=department.get_section
     if section==0
       puts "There is no seat in#{student_department}"
     else
       sect=section[0]
       rollno=department.get_name+section
       department.add_rollno(student_name,rollno)
       "You have been enrolled to #{student_department}" \
       "\nYou have been allotted section #{sect}" \
       "\nYour roll number is #{rollno}"
     end
  end

  def change_dept(student_name, student_department)
    ## write some logic to frame the string below
    rollno=""
    old_dept=""
    self.departments.each do |dept|
      rollno=dept.get_details(student_name)
      if rollno != nil
        i=-1
        while rollno[i]>='0' and rollno[i] <='9'
            i=i-1
        end
        #puts "Section is #{rollno[i]}"
        old_dept=dept
        break
      end
    end
    oldrollno=rollno
    department = self.departments.detect { |dept| dept.get_name == student_department}
    #puts "present required department is #{department.get_name}"
    if old_dept.get_name == department.get_name
      puts "you have already enrolled in this department#{old_dept.get_name}"
    else
      section=department.get_section
      if section == 0
        "There is no seat in #{student_department}" \
      else
        old_dep=old_dept.get_name
        len=old_dep.length
        num=rollno[len+1..rollno.length-1]
        #puts "roll no is #{num}"
        old_dept.remove_rollno(student_name,old_dep,rollno)
        sect=section[0]
        rollno=department.get_name+section
        department.add_rollno(student_name,rollno)
        len=old_dep.length
        old_dept.adjust_rollno(len,num,oldrollno)
        "You have been enrolled to #{student_department}" \
        "\nYou have been allotted section #{sect}" \
        "\nYour roll number is #{rollno}"
      end
    end
  end
  
  def change_section(student_name, section)
    ## write some logic to frame the string below
    rollno=""
    old_dept=""
    list=""
    self.departments.each do |dept|                       # This block is for finding the department
      rollno=dept.get_details(student_name)               # of the given student
      if rollno != nil
        #puts "rollno is #{rollno}"
        i=-1
        while rollno[i]>='0' and rollno[i] <='9'
            i=i-1
        end
        #puts "Section is #{rollno[i]}"
        old_dept=dept
        break
      end
    end
    old_dep=old_dept.get_name
    len=old_dep.length
    presec=old_dep[len]
    oldrollno=rollno
    if presec==section
      list=list+"you are already alloted to this section#{presec}"
    else
      sectcnt=old_dept.get_seats_in_section(section)
      if sectcnt>=1
        old_dep=old_dept.get_name
        len=old_dep.length
        num=rollno[len+1..rollno.length-1]
        old_dept.remove_rollno(student_name,old_dep,rollno)
        sect=old_dept.get_specific_section_rollno(section)
      #sect=section[0]
      #rollno=old_dept.get_name+section.to_s
        rollno=old_dept.get_name+sect.to_s
        old_dept.add_rollno(student_name,rollno)
        len=old_dep.length
        old_dept.adjust_rollno(len,num,oldrollno)
      #{}"You have been enrolled to #{student_department}" \
        list=list+"\nYou have been allotted section #{section}" 
        list=list+"\nYour roll number is #{rollno}"
      else
        list=list+"no seats in #{section}section"
      end
    end
    puts ""+list
    #department = self.departments.detect { |dept| dept.get_name == student_department}
  end

  def department_view(student_dept)
    ## write some logic to frame the string below
    department = self.departments.detect { |dept| dept.get_name == student_dept}
    #{}"List of students:" \
        department.show_details
  end

  def section_view(student_dept, section)
    ## write some logic to frame the string below
    department=self.departments.detect{|dept| dept.get_name==student_dept}
    dept=department.get_name
    len1=dept.length
    department.sec_show_details(section,len1)
    #"List of students:" \
    #"\nTom - MECB01"
  end

  def student_details(student_name)
    ## write some logic to frame the string below
    list=""
    f=0
    self.departments.each do |dept|
      rollno=dept.get_details(student_name)
      dep1=dept.get_name
      if rollno!=nil
        f=1
        len1=dep1.length
        sec=rollno[len1]
        list="#{student_name}-#{dep1}-section#{sec}-#{rollno}"
        break
      end
    end
    if f==0
      list=list+"no student with such name#{student_name}"
    end
    #"Tom - MECH - Section B - MECB01"
    list
  end
end
