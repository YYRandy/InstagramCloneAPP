//
//  NotificationCellViewModel.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/18.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    var timestampString: String {
        let formattar = DateComponentsFormatter()
        formattar.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formattar.maximumUnitCount = 1
        formattar.unitsStyle = .abbreviated
        return formattar.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(notification:Notification) {
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    func follow() {
      
        UserService.follow(uid: notification.uid) { _ in
            NotificationViewModel.uploadNotification(toUid: self.notification.uid, type: .follow)
            self.notification.isFollowed = true
        }
    }
    
    
    func unfollow() {
        UserService.unfollow(uid: notification.uid) {_ in
            self.notification.isFollowed = false
        }
    }
    
    
    func checkIfUserIsFollowed() {
        guard notification.type == .follow else { return }
        UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
            self.notification.isFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        guard let postId = notification.postId else { return }
        
        COLLECTION_POST.document(postId).getDocument { snapshot, _ in
            self.notification.post = try? snapshot?.data(as: Post.self)
        }
    }
    
    func fetchNotificationUser() {
        COLLECTION_USER.document(notification.uid).getDocument { snapshot, _ in
            self.notification.user = try? snapshot?.data(as: User.self)
          
        }
    }
}
