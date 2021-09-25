//
//  NotificationsViewModel.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/18.
//

import SwiftUI
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notification = [Notification]()
    
    init(){
        fetchNotifications()
    }
    
    func fetchNotifications() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notification").order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.notification = documents.compactMap({ try? $0.data(as: Notification.self)})
            print(self.notification)
        }
    }
    
    
   static func uploadNotification(toUid uid: String, type: NotificatonType, post: Post? = nil) {
        guard let user = AuthViewModel.shared.currretUser else { return }
    guard uid != user.id else { return }
    
        
        var data:[String: Any] = ["timestamp": Timestamp(date: Date()),
                                  "username": user.username,
                                  "uid": user.id ?? "",
                                  "profileImageUrl": user.profileImageUrl,
                                  "type": type.rawValue]
        
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notification").addDocument(data: data)
    }
}
