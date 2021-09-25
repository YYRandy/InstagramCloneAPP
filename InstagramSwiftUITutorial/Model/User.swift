//
//  User.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/15.
//


import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    let profileImageUrl: String
    let fullname: String
    
    //https://qiita.com/jyu0414/items/bf4661e2027fc30a29d0
    @DocumentID var id: String?
    var bio: String?
    var stats: UserStats?
    var isFollowed: Bool? = false
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
    
}

struct UserStats: Decodable {
    var following: Int
    var post: Int
    var followers: Int
}
