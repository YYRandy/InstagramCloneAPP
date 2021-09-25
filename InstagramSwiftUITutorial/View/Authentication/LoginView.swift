//
//  LoginView.swift
//  InstagramSwiftUITutorial
//
//  Created by Yajima Youhei on 2021/09/14.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple,Color.blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                VStack{
                    
                    Image("title")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    
                    
                    //email field
                    
                    VStack(spacing:20){
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        //password
                        CustomSecureField(text: $password, placeholder: Text("Password"))
                            
                                .padding()
                                .background(Color(.init(white: 1, alpha: 0.15)))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .padding(.horizontal, 32)
                    }
                    //forget password
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: ResetPasswordView(email: $email)) {
                            Text("Forget Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing,28)
                        }
                    }
                    //sign in
                    
                    Button(action: {
                        viewModel.login(withEmail: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                            .clipShape(Capsule())
                            .padding()
                    })
                    Spacer()
                    //go to sign up
                    NavigationLink(
                        destination: RegistrationView().navigationBarHidden(true),
                        label: {
                            HStack {
                                Text("Don't have an account?")
                                    .font(.system(size: 14))
                                Text("Signg Up")
                                    .font(.system(size: 14, weight: .semibold))
                                
                            }
                            .foregroundColor(.white)
                        })
                        .padding(.bottom, 16)
                   
                }
                .padding(.top, -44)
            }
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
