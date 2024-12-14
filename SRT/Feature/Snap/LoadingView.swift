//
//  LoadingView.swift
//  SRT
//
//  Created by 박성민 on 12/14/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("로딩 중...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
                .padding()
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}
#Preview {
    LoadingView()
}
