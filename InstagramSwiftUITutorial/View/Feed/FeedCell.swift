//
//  FeedCell.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/13.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike: Bool { return viewModel.post.didLike ?? false}
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                KFImage(URL(string: viewModel.post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight:  .semibold))
            }
            .padding([.leading,.bottom],8)
            
            //post image
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            
            //action button
            HStack(spacing:8){
                Button(action: {
                    didLike ? viewModel.unlike() : viewModel.like()
                }) {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? .red : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                    
                }
                
             NavigationLink(
                destination: CommentsView(post: viewModel.post),
                label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
                
                Button(action: {}) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                    
                }
            }
            .padding(.leading, 4)
            .foregroundColor(.black)
            
            
            //caption
            Text(viewModel.lileString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading,8)
                .padding(.bottom,2)
            
            
            HStack{
                Text(viewModel.post.ownerUsername).font(.system(size: 14,weight: .semibold)) + Text(" \(viewModel.post.caption)").font(.system(size: 15))
                
            }.padding(.horizontal, 8)
            
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        
        }
    }
}

//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell()
//    }
//}