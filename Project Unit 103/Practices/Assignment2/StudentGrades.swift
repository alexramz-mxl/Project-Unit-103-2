//
//  StudentGrades.swift
//  Project Unit 103
//
//  Created by uvminstaller on 27/08/25.
//

import SwiftUI

struct Student: Identifiable {
    let id = UUID()
    var name: String
    var grade: [Double]
    
    var average: Double {
            let total = grade.reduce(0, +)
            return grade.isEmpty ? 0 : total / Double(grade.count)
    }
}
struct ContenView: View {
    @State private var students: [Student] = [
        Student(name: "Alice", grade: [95, 68,83]),
        Student(name: "Bob", grade: [88,76,85]),
        Student(name: "Charlie", grade: [92, 85, 93]),
    ]
    @State private var name: String = ""
    @State private var grade: String = ""
    @State private var sortDescending: Bool = true
    
    var sortedStudents: [Student] {
        students.sorted {
            if sortDescending {
                return $0.average > $1.average
            } else {
                return $0.average < $1.average
            }
        }
    }
    
    var averageGrade: Double {
        guard !students.isEmpty else { return 0 }
        let total = students.reduce(0) { $0 + $1.average }
        return total / Double(students.count)
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                HStack {
                    
                    Spacer()
                    Text("GradeBook")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("STUDENT GRADES")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding(.bottom, 5)
                    Spacer()
                    
                }
                HStack {
                    Spacer()
                
                HStack(spacing: 8) {
                    Spacer()
                    Text("AVERAGE GRADE: \(averageGrade, specifier: "%.1f")")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    Button(action: {
                        sortDescending.toggle()
                    })  {
                        Image(systemName: sortDescending ? "arrow.up.arrow.down" : "arrow.down.arrow.up")
                            .foregroundColor(.blue)
                    }
                }
                
                    Spacer()
            }
            .padding(.bottom)
                
                List(sortedStudents) { student in
                    Text("\(student.name) - \(student.average, specifier: "%.1f")")
                }
                
                HStack {
                    TextField("Student Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)
                    
                    TextField("Grade", text: $grade)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)
                    
                    Spacer()
                    
                    Button(action: {
                        if let gradeValue = Double(grade), !name.isEmpty {
                            let newStudent = Student(name: name, grade: [gradeValue])
                            students.append(newStudent)
                            name = ""
                            grade = ""
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}
    struct ContenView_Previews: PreviewProvider {
        static var previews: some View {
            ContenView()
        }
    }
    
    @main
    struct StudentGradesApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
