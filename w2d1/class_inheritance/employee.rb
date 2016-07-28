class Employee

attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @boss = nil
  end

  def set_boss(boss)
    @boss = boss
  end

  def bonus(multiplier)
    multiplier * @salary
  end
end
