import UIKit

class Student {
    private var name: String
    private var age: Int
    private var grades: [Int]
    
    init(name: String, age: Int, grades: [Int]){
        self.name = name
        self.age = age
        self.grades = grades
    }
    
    func averageGrade() -> Double {
        guard !grades.isEmpty else { return 0.0 }
        let total = grades.reduce(0, +)
        return Double(total) / Double(grades.count)
        
    }
    
    func isPassing() -> Bool {
        return averageGrade() >= 60.0
    }
    
    func getName() -> String {
        return name
    }
    
}
    
    class Course {
        private var students: [Student] = []
        
        func addStudent(_ student: Student) {
            students.append(student)
        }
        
        func courseAverage() -> Double {
            guard !students.isEmpty else { return 0.0 }
            let total = students.reduce(0.0) { $0 + $1.averageGrade() }
            return total / Double(students.count)
            
        }
        
        func topStudent() -> Student? {
            return students.max(by: {$0.averageGrade() < $1.averageGrade() })
            
        }
        
        func getStudents() -> [Student] {
            return students
        }
    }
    
    
    let student1 = Student(name: "Alice", age: 20, grades: [90, 85, 78])
    let student2 = Student(name: "Bob", age: 23, grades: [95, 89, 91])
    let student3 = Student(name: "Alexis", age: 35, grades: [80, 85, 92])
    let student4 = Student(name: "Jonathan", age: 22, grades: [60, 55, 61])
    
    let course = Course()
    course.addStudent(student1)
    course.addStudent(student2)
    course.addStudent(student3)
    course.addStudent(student4)
    
    
    for student in course.getStudents() {
        print("Student: \(student.getName())")
        print(String(format: "Average: %.2f", student.averageGrade()))
        print("Status: \(student.isPassing() ? "Passing" : "Failing")\n")
    }
    
    print(String(format: "Course Average: %.2f\n", course.courseAverage()))
    
    if let top = course.topStudent() {
        print("Top Student: \(top.getName())")
        print(String(format: "Top Average: %.2f", top.averageGrade()))
    }
        
