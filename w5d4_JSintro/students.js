function Student (firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;

  this.name = `${firstName} ${lastName}`;

  this.courses = [];
  this.courseLoad = {};
}


function Course (courseName, department, numberOfCredits, days, time) {
  this.courseName = courseName;
  this.department = department;
  this.numberOfCredits = numberOfCredits;
  this.students = [];
  this.days = days;
  this.time = time;
}

Student.prototype.enroll = function (course) {
  if (!this.courses.includes(course) && !this.hasConflict(course)) {
    this.courses.push(course);

    if (this.courseLoad[course.department]) {
      this.courseLoad[course.department] += course.numberOfCredits;
    } else {
      this.courseLoad[course.department] = course.numberOfCredits;
    }
  } else {
    return "found conflict";
  }
};

Student.prototype.hasConflict = function (course) {
  let conflict = false;
  this.courses.forEach (function (existingCourse) {
    if (existingCourse.conflictsWith(course)) {
      conflict = true;
    }
  });
  return conflict;
};

Course.prototype.addStudent = function (student) {
  this.students.push(student);
  student.enroll(this);
};

Course.prototype.conflictsWith = function (otherCourse) {
  if (this.time === otherCourse.time) {
    for (let  i = 0; i < this.days.length; i++) {
      if (otherCourse.days.includes(this.days[i])) {
        return true;
      }
    }
  }

  return false;
};

let algebra = new Course ('Algebra', 'Math', 5, ["m", "th"], 4);
let statistics = new Course ('Statistics', 'Math', 5, ["t"], 4);

// let result = algebra.conflictsWith(statistics);

let sisi = new Student ('Sisi', 'Yao');
algebra.addStudent(sisi);

let result = sisi.enroll(statistics);




console.log(result);

//
//
// let ruby = new Course ('Ruby 101', 'Comp Sci', 9);
//
//
//
// statistics.addStudent(sisi);
//
// console.log(sisi.courseLoad);
