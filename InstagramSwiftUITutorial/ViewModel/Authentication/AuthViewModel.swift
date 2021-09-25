//
//  AuthViewModel.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/14.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currretUser: User?
    @Published var didSendResetPasswordLink = false
    
    static let shared = AuthViewModel()
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login failed \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    
    func register(withEmail email:String, password: String, image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) {imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                
                guard let user = result?.user else { return }
                
                print("Successfully registerd user...")
                
                let data = ["email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageUrl": imageUrl,
                            "uid": user.uid]
                
                COLLECTION_USER.document(user.uid).setData(data){ _ in
                    print("Successfully uploaded user data...")
                    self.userSession = user
                    self.fetchUser()
                }
            }
        }
    }
    
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    
    func resetPassword(withemail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
            print("Failed to send link with error \(error.localizedDescription)")
            }
            
            self.didSendResetPasswordLink = true
        }
    }
    
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USER.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currretUser = user
         
        }
    }
    
    
}

