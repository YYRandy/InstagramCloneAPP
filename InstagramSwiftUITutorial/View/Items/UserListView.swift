//
//  UserListView.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/13.
//

import SwiftUI

struct UserListView: View {

    @ObservedObject var viewModel: SearchViewModel
    @Binding var serchText: String
    
    var users:[User] {
        return serchText.isEmpty ? viewModel.users : viewModel.filteredUsers(serchText)
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(users){ user in
                    NavigationLink(
                        destination: LazyView(ProfileView(user: user)),
                        label: {
                            UserCell(user: user)
                                .padding(.leading)
                        })
                   
                }
            }
        }
    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}
