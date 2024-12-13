//
//  StartView.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack{
            VStack{
                
                Spacer()
                    .frame(height: 10)
                Image("SRTLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Spacer()
                    .frame(height: 150)
                
                HStack{
                    Text("Safety Report")
                        .font(.system(size: 32,weight: .bold))
                    
                    Text("SRT")
                        .font(.system(size: 32,weight: .bold))
                        .customGradient(style: .foreground)
                }   
                
                NavigationLink{
                    LoginView()
                        .navigationBarBackButtonHidden()
                }label:{
                    CustomButton(label: "시작하기")
                }
            }
        }
    }
}

#Preview {
    StartView()
}
