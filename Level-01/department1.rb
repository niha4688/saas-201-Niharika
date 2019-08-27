class Department
	attr_accessor :deptname , :sections, :studentslist
	def initialize(name)
		self.deptname=name
		self.sections={'A'=>5,'B'=>5,'C'=>5}
		self.studentslist={}
	end
	def show
		puts self.deptname
	end

	def show_details
        li="Students List "
		studentslist.each do |key,val|
			li=li+"\n#{key} has roll no #{val}"
		end
		li
	end

    def sec_show_details(sec1,len1)
    	f=0
    	li="students list "
    	studentslist.each do |key,val|
    		sec=val[len1]
    		if sec1==sec
    			li=li+"\n#{key}-#{val}"
    			f=1
    	    end
    	end
    	if f==0
    		puts "students are not yet enrolled in #{sec1}"
        end
        li
    end

    def get_sec_name(sect)
    	sections[sect]
    end

    def get_section_name(nam)
    	studentlist.each do |key,val|
    		#name1=key.upcase
    		if key.downcase==nam.downcase
    			return studentslist[nam]
    		end
    	end
    end

	def get_details(stud_name)
		studentslist[stud_name]
	end

	def get_name
		deptname
	end

	def add_rollno(stud_name,rollno)
		studentslist[stud_name]=rollno
		puts studentslist[stud_name]
	end		

	def remove_rollno(stud_name,old_dep1,rolno)
		studentslist.delete(stud_name)
		len1=old_dep1.length
		sect=rolno[len1]
		self.sections[sect]=self.sections[sect]+1
	end

	def get_seats_in_section(section)
		 self.sections[section] 
	end

	def get_specific_section_rollno(section)
		sect=5-self.sections[section]+1
		sectn=format('%02d',sect)
		sect=section+sectn.to_s
		self.sections[section]=self.sections[section]-1
		return sect
	end

	def get_section
		if self.sections['A'] >= 1
			sect=5-self.sections["A"]+1
			sect='A'+sect.to_s
			self.sections['A']=self.sections['A']-1
		elsif self.sections['B'] >=1
			sect=5-self.sections["B"]+1
			sect='B'+sect.to_s
			self.sections['B']=self.sections['B']-1
		elsif self.sections['C'] >= 1
			sect=5-self.sections["C"]+1
			sect='C'+sect.to_s
			self.sections['C']=self.sections['C']-1			
		else
			sect=0
		end
		return sect
	end

	def adjust_rollno(length,numb,rolno)
		rolln=rolno[0..length]
		studentslist.each do |key,val|
			len=val.length
			rollno=val[length+1..len-1]
			k=rollno.to_i-1
			if rollno>numb
				rollno=rollno.to_i-1
				numb=format('%02d',k)
				studentslist[key]=rolln+numb.to_s
           end
       end
    end

    
end


