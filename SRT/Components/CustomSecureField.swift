//
//  CustomTextField.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import SwiftUI

struct CustomSecureField: View {
    var image: String
    @Binding var text: String
    var placehorder: String
    var body: some View {
        ZStack(alignment: .leading){
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .padding(.leading,15)
            
            
            if text.isEmpty {
                Text(placehorder)
                    .padding(.leading, 45)
                    .foregroundStyle(.gray.opacity(0.8))
                    .font(.system(size: 18))
            }
            
            SecureField(text: $text, label: { Image(systemName: image) })
                .padding(.leading, 45)
                .frame(width: 350,height: 60)
                .background(.gray.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

#Preview {
    @Previewable @State var sampleText: String = ""
    CustomSecureField(image:"SRTLogo",text: $sampleText, placehorder: "Enter text")
}
