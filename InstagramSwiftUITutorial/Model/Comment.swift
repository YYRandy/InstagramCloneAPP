//
//  Comment.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/17.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let postOwnerUid: String
    let profileImageUrl: String
    let commentText: String
    let timestamp: Timestamp
    let uid: String
    
    var timestampString: String? {
        let formattar = DateComponentsFormatter()
        formattar.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formattar.maximumUnitCount = 1
        formattar.unitsStyle = .abbreviated
        return formattar.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
}
