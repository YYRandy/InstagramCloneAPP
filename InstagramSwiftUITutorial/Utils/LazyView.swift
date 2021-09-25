//
//  LazyView.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/18.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
    
}
