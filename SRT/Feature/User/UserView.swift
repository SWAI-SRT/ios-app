//
//  UserView.swift
//  SRT
//
//  Created by 박성민 on 11/18/24.
//

import SwiftUI

struct UserView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject var userViewModel = UserViewModel()
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 30)
            HStack{
                Spacer()
                    .frame(width: 30)
                Button(
                    action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 15,height: 30)
                            .foregroundStyle(.black)
                    }
                )
                Spacer()
                    .frame(width: 20)
                
                Text("내 건강정보 수정")
                    .font(.system(size: 20,weight: .bold))
                
                Spacer()
            }
            Spacer()
                .frame(height: 30)
            HStack{
                Spacer()
                    .frame(width: 40)
                VStack(alignment: .leading){
                    Text("아래에서 자신 신고에 필요한")
                    Spacer()
                        .frame(height: 10)
                    Text("건강정보를 수정할 수 있어요.")
                }
                .font(.system(size: 25,weight: .bold))
                .customGradient()
                
                Spacer()
            }
            Spacer()
                .frame(height: 40)
            HStack{
                Spacer()
                    .frame(width: 40)
                Text("이름")
                    .foregroundStyle(.gray)
                    .font(.system(size: 20,weight: .bold))
                
                TextField(text: $userViewModel.newNickName, label: {
                    if userViewModel.nickName.isEmpty{
                        Text("Loding...")
                    } else {
                        Text("\(userViewModel.nickName)")
                    }
                })
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding([.trailing,.leading],20)
                
            }
            Spacer()
                .frame(height: 40)
            VStack(alignment: .leading, spacing: 10) {
                Text("자세한 건강 정보")
                    .foregroundStyle(.gray)
                    .font(.system(size: 20,weight: .bold))
                    
                InfoRow(title: "보유 알레르기", value: "사과, 복숭아, ...")
                InfoRow(title: "기저 질환", value: "-")
                InfoRow(title: "복용 중인 약물", value: "ADHD 약 (콘서타), ...")
                InfoRow(title: "혈액형", value: "AB")
                InfoRow(title: "몸무게", value: "80 kg")
                InfoRow(title: "신장", value: "175 cm")
                        
                Spacer()
            }
            .padding(20)
            
            CustomButton(
                action: {
                    userViewModel.fetchUser()
                },
                label: "저장하기"
            )
            Spacer()
                .frame(height: 40)
        }
        .onAppear{
            userViewModel.getUser()
            
            userViewModel.onDismiss = {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .foregroundStyle(.gray)
                .font(.system(size: 18,weight: .bold))
                .frame(width: 100, alignment: .leading)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
        }
    }
}

#Preview {
    UserView()
}
