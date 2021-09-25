//
//  FeedCellViewModel.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/17.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var lileString: String {
        let label =  post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    var timestampString: String {
        let formattar = DateComponentsFormatter()
        formattar.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formattar.maximumUnitCount = 1
        formattar.unitsStyle = .abbreviated
        return formattar.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        
        
        COLLECTION_POST.document(postId).collection("post-likes").document(uid).setData([:]){_ in
            COLLECTION_USER.document(uid).collection("user-likes").document(postId).setData([:]) { _ in
                
                COLLECTION_POST.document(postId).updateData(["likes": self.post.likes + 1])
                
                NotificationViewModel.uploadNotification(toUid: self.post.ownerUid, type: .like, post: self.post)
                
                self.post.didLike = true
                self.post.likes += 1
            }
        }
    }
    
    func unlike() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POST.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USER.document(uid).collection("user-likes").document(postId).delete { _ in
                
                COLLECTION_POST.document(postId).updateData(["likes": self.post.likes - 1])
                
                self.post.didLike = false
                self.post.likes -= 1
            }
        }
        
    }
    
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USER.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.post.didLike = didLike
        }
    }
}
