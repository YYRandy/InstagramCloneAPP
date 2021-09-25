//
//  SearchViewModel.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/15.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var  users = [User]()
  
    init() {
        fetchUsers()
           }
    
    func fetchUsers() {
        COLLECTION_USER.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({try? $0.data(as: User.self)})
            print(self.users)
        }
      
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) ||  $0.username.contains(lowercasedQuery) })
           
    }
}
