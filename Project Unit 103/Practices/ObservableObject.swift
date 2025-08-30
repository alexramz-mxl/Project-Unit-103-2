//
//  ObservableObject.swift
//  Project Unit 103
//
//  Created by uvminstaller on 28/08/25.
//


import SwiftUI


// Model -> ObservableObject
class UserModel: ObservableObject {
    @Published var name: String = "Alexis Pastrana"
    @Published var age: Int = 35
}


//Parent View -> ProfileView
struct MainView: View {
    
    @StateObject private var userModel = UserModel()
    
    var body: some View {
        // Call the views
        ProfileView(user: userModel)
        
        EditProfileView(user: userModel)
    }
}

//ProfileView
struct ProfileView: View {
    
    @ObservedObject var user: UserModel
    
    var body: some View {
        VStack{
            Text("User Profile")
                .font(.headline)
                .tracking(2)
            Text("Name: \(user.name)")
            Text("Age: \(user.age)")
        }
        .padding()
        .background(Color.blue.opacity(0.5))
    }
}


//EditProfileView
struct EditProfileView: View {
    
    @ObservedObject var user: UserModel
    
    var body: some View {
        VStack{
            
            Text("Edit Profile ")
                .font(.headline)
            TextField("Enter your name:", text: $user.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Stepper("Age: \(user.age)", value: $user.age, in: 0...100)
                .padding()
        }
        
        .padding()
        .background(Color.gray)

    }
}

#Preview{
    MainView()
}
