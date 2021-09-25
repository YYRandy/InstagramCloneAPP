//
//  Notification.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/18.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificatonType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
    
}

enum NotificatonType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "  liked one of your posts."
        case .comment: return "  commented on one of your posts."
        case .follow: return "  started following you."
        }
    }
}
