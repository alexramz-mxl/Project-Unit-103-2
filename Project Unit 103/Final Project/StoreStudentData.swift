//
//  StoreStudentData.swift
//  Project Unit 103
//
//  Created by uvminstaller on 03/09/25.
//

import SwiftUI

class StudentV2: Identifiable {
        var id: Int
        var name: String
        var grades: [Double]
    
        var average: Double {
            if grades.isEmpty { return 0}
            return grades.reduce(0, +) / Double(grades.count)
    }
        
    init(ID: Int, name: String, grades: [Double]) {
            self.id = ID
            self.name = name
            self.grades = grades
        }
    }
    
    class Course: ObservableObject {
        var name: String
        @Published var students: [StudentV2] = []
        
        init(name: String) {
            self.name = name
        }
        
        func addStudent(_ student: StudentV2) {
            students.append(student)
        }
        
        func removeStudent(byID ID: Int) {
            students.removeAll { $0.id == ID }
        }
        
        func sortByAverageAscending() {
            students.sort { $0.average < $1.average}
        }
        
        func sortByAverageDescending() {
            students.sort { $0.average > $1.average}
        }
    }

struct StoreStudentData: View {
    @StateObject private var course = Course(name: "")
    @State private var studentName: String = ""
    @State private var studentGrades: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Button {
                        course.sortByAverageAscending()
                    } label: {
                        Image(systemName: "arrow.up")
                            .font(.title2)
                    }
                    Spacer()
                    Button {
                        course.sortByAverageDescending()
                    }   label: {
                        Image(systemName: "arrow.down")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                
                List {
                    ForEach(course.students) { student in
                        Text("\(student.name): Average: \(String(format: "%.2f", student.average))")
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let student = course.students[index]
                            course.removeStudent(byID: student.id)
                            
                        }
                    }
                }
                
                
                HStack {
                    TextField("NAME:", text: $studentName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("GRADES", text: $studentGrades)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button {
                        let gradeStrings = studentGrades.split(separator: ",")
                        var grades: [Double] = []
                        
                        for gradeString in gradeStrings {
                            let trimmed = gradeString.trimmingCharacters(in: .whitespaces)
                            if let number = Double(trimmed) {
                                grades.append(number)
                            }
                        }
                        
                        if studentName != "" && !grades.isEmpty {
                            let newStudent = StudentV2(ID: course.students.count + 1, name: studentName, grades: grades)
                            course.addStudent(newStudent)
                            
                            studentName = ""
                            studentGrades = ""
                            
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 8)
                }//END: VStack
                .navigationTitle(Text("STORE STUDENT DATA"))
            }//END: NavigationView
        }
    }
#Preview {
    StoreStudentData()
}
