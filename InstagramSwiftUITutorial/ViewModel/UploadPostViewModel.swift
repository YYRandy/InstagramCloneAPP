//
//  UploadPostViewModel.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/16.
//

import SwiftUI
import Firebase


class UploadPostViewModel: ObservableObject {
    
    func uploasPost(caption: String, image: UIImage, completion: FirestoreCompletion ) {
        guard let user = AuthViewModel.shared.currretUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": user.id ?? "",
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String : Any]
            
            COLLECTION_POST.addDocument(data: data, completion: completion)
        }
    }
}

