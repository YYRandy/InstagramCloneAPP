//
//  Constants.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/15.
//

import Firebase

let COLLECTION_USER = Firestore.firestore().collection("user")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POST = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")

