//
//  ProfileHeaderView.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/14.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
   @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16){         
                    UserStatView(value: viewModel.user.stats?.post ?? 0, title: "Post")
                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                    UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
                }
                .padding(.trailing, 32)
              
            }
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            
            
            if let bio = viewModel.user.bio {
            Text(bio)
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 1)
            }
            
            
            HStack {
               Spacer()
                
                ProfileActionButtonView(viewModel: viewModel)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
        }
    }
}



//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
//}
