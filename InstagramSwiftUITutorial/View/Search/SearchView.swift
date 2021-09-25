//
//  SearchView.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/13.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel = SearchViewModel()
    var body: some View {
        
        
        ScrollView{
           
            
            
            //search bar
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            
            ZStack{
                if inSearchMode {
                    UserListView(viewModel: viewModel, serchText: $searchText)
                }else {
                    PostGridView(config: .explore)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
