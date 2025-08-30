//
//  Binding.swift
//  Project Unit 103
//
//  Created by uvminstaller on 28/08/25.
//

import SwiftUI

struct NameView: View {
    
    @State var name: String = ""
    
    var body: some View {
        Form {
            Text("What's your name?")
            
            TextField("Enter your name", text: $name)
        }
    }
}

// It is used when you want to have multiple views
//The child view will access (read and write) the parent variavlble

//Parent view
struct SwitchView: View {
    
    @State private var isOn = false
    
    var body: some View {
        VStack{
            
            //Ternary condition
            Text(isOn ? "WiFi is ON" : "WiFi is OFF")
            
            //Toggle View -> Child View
            ToggleView(isOn: $isOn)
            
            
        }
    }
}


//Child view
struct ToggleView: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle("WiFi", isOn: $isOn)
            .padding()
    }
}
#Preview {
    //NameView()
    SwitchView()
}
