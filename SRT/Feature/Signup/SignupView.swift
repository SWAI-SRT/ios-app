//
//  SignupView.swift
//  SRT
//
//  Created by 박성민 on 9/21/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var signupViewModel = SignupViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            Spacer()
                .frame(height: 70)
            Button{
                self.presentationMode.wrappedValue.dismiss()
            }label:{
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 15,height: 25)
                    .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(.leading,30)
            Spacer()
                .frame(height: 20)
            Text("회원가입")
                .font(.system(size: 28,weight: .bold))
                .customGradient()
            
            Spacer()
                .frame(height: 50)
            
            VStack(spacing: 20){
                CustomTextField(image: "EmailLogo", text: $signupViewModel.email, placehorder: "example@gmail.com")
                
                CustomTextField(image: "NameLogo", text: $signupViewModel.name, placehorder: "박성민")
                
                CustomSecureField(image: "PasswordLogo", text: $signupViewModel.password, placehorder: "********")
                
                CustomSecureField(image: "PasswordLogo", text: $signupViewModel.passwordCheck, placehorder: "********")
            }
            
            Spacer()
                .frame(height: 60)
            
            
            CustomButton(action: {
                signupViewModel.signup()
            }, label: "회원가입")
            Spacer()
                .frame(height: 100)
        }
    }
}

#Preview {
    SignupView()
}
