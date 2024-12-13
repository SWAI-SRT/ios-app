//
//  ReportOKView.swift
//  SRT
//
//  Created by 박성민 on 11/16/24.
//

import SwiftUI

struct ReportOKView: View {
    var body: some View {
        VStack{
            HStack{
                Text("신고가 완료 되었습니다")
                    .font(.system(size: 30,weight: .bold))
                    .customGradient()
                Spacer()
                    .frame(width: 60)
            }
            Spacer()
                .frame(height: 20)
            HStack{
                Text("신고가 정상적으로 모두 완료되었습니다.")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
                
                Spacer()
                    .frame(width: 90)
            }
            
            Spacer()
                .frame(height: 50)
            ZStack{
                Image("CircleLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230)
                
                Image("CheckLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top,20)
            }
            
            Spacer()
                .frame(height: 100)
            
            CustomButton(action: {}, label: "완료하기")
        }
    }
}

#Preview {
    ReportOKView()
}
