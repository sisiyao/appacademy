require_relative 'employee'

class Manager < Employee

attr_reader :employees
  def initialize(name, title, salary)
    @employees = []
    super(name, title, salary)
  end

  def add_employee(employee)
    @employees << employee
    employee.set_boss(self)
  end

  def list_employees
    employees.each{|e| puts e.name}
  end
  def bonus(multiplier)
    multiplier * total_employee_salary
  end

  def total_employee_salary
    # return 0 if @employees.empty?

    total = 0
    @employees.each do |employee|
      total += employee.salary
      if employee.is_a?(Manager)
        total += employee.total_employee_salary
      end
    end
    total
  end
end#class

david = Employee.new("David", "TA", 10_000)
shawna = Employee.new("Shawna", "TA", 12_000)
darren = Manager.new("Darren", "TA Manager", 78_000)
ned = Manager.new("Ned", "Founder", 1_000_000)
ned.add_employee(darren)
darren.add_employee(shawna)
darren.add_employee(david)
