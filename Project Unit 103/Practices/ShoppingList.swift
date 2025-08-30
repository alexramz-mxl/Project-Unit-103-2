//
//  ShoppingList.swift
//  Project Unit 103
//
//  Created by uvminstaller on 26/08/25.
//

import SwiftUI

struct ShoppingList: View {
    @State private var shoppingItems: [String] = ["Eggs", "Apples"]
    @State private var newItem = ""
    
    var body: some View {
        NavigationView{
            VStack{
                //Text("SHOPPING LIST 🛒")
                //.font(.title).font(.largeTitle)
                //.tracking(2)
                //.padding()
                List(shoppingItems, id: \.self) { item in
                    Text(item)
                }
                
                HStack{
                    TextField("Add new item", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    Button(action: addItem){
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                    }
                    .disabled(newItem.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding([.horizontal, .bottom])
            }
            
            .navigationTitle("SHOPPING LIST  🛒")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Sort A → Z", action: sortItems)
                        Button("Reverse Order", action: reverseItems)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
        

func addItem() {
    _ = newItem.trimmingCharacters(in: .whitespaces)
        guard !newItem.isEmpty else { return }
        shoppingItems.append(newItem)
        newItem = ""
    }
    
    func sortItems() {
        shoppingItems.sort(by: { $0.lowercased() < $1.lowercased() })
    }
    
    func reverseItems() {
        shoppingItems.reverse()
    }
}
#Preview {
ShoppingList()

        }

