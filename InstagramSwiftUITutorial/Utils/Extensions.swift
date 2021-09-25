//
//  Extensions.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/14.
//

import UIKit

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
