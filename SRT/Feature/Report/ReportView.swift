//
//  ReportView.swift
//  SRT
//
//  Created by 박성민 on 9/22/24.
//

import SwiftUI

struct ReportView: View {
    func reportGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [.gradient1, Color(red: 1/255, green: 169/255, blue: 255 / 255)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            HStack{
                Spacer()
                    .frame(width: 30)
                
                NavigationLink{
                    UserView()
                        .navigationBarBackButtonHidden()
                }label: {
                    Image(systemName: "text.justify")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundStyle(.black)
                }
                
                Spacer()
            }
            Spacer()
                .frame(height: 80)
            
            Text("긴급 상황이 발생하였나요?")
                .font(.system(size: 28))
                .customGradient()
            Text("아래 버튼을 터치하세요.")
                .font(.system(size: 28.5,weight: .bold))
                .foregroundStyle(
                    reportGradient()
                )
            
            Spacer()
                .frame(height: 50)
            
            NavigationLink{
                SnapView()
                    .navigationBarBackButtonHidden()
            }label:{
                ZStack{
                    Circle()
                        .frame(width: 170)
                        .foregroundStyle(reportGradient())
                            
                    Circle()
                        .frame(width: 210)
                        .foregroundStyle(reportGradient().opacity(0.3))
                            
                    Image("ReportLogo")
                        .resizable()
                        .frame(width: 56,height: 64)
                }
            }
            
            Spacer()
                .frame(height: 50)
            
            HStack{
                Image("WaringLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                
                VStack(alignment: .leading){
                    Text("119로 즉시 문자메시지가 발송되므로")
                    Text("신중하게 진행해주세요.")
                }
                .foregroundStyle(.gradient2)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ReportView()
}
