//
//  PostView.swift
//  Project Unit 103
//
//  Created by uvminstaller on 28/08/25.
//

import SwiftUI

class PostModel: ObservableObject {
    @Published var likeCount: Int
    @Published var caption: String
    
    let imageName: String
    let date: String
    
    init(imageName: String, caption: String, date: String, likeCount : Int = 0) {
        self.imageName = imageName
        self.caption = caption
        self.date = date
        self.likeCount = likeCount
    }
}

struct PostView: View {
    @State private var isLiked = false
    
    @ObservedObject var post: PostModel
    
    var body: some View {
        VStack {
            HStack {
                
                Image(systemName: "person.circle")
                    .imageScale(.large)
                    
                
                Text("Alexis.Pastrana")
                    .tracking(1)
            }
            
            Image("photo_post")
                .resizable()
                .aspectRatio(2/3, contentMode: .fill)
                .frame(width: .infinity)
            
            HStack {
                    
                LikeButton (isLiked: $isLiked)
                
                Text("\(post.likeCount)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
                Text(post.caption)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(post.date)
                .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
        }
        
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .padding()
        .onChange(of: isLiked) {
            if isLiked {
            // Increment the post likeCount + 1
                post.likeCount += 1
        } else {
            post.likeCount = max(0, post.likeCount - 1)
            }
        }
    }
}

struct LikeButton: View {
    
    @Binding var isLiked: Bool
    
    var body: some View {
        Button(action: {
            isLiked.toggle()
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? .red : .gray)
                .imageScale(.large)
        }
    }
}

#Preview {
    
    let newPost = PostModel(
        imageName: "photo_post",
        caption: "Denali is the tallest mountain in North America #Landscape #Alaska",
        date: "August 2025"
    )
    PostView(post: newPost)
}
