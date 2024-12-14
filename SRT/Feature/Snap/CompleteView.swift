//
//  CompleteView.swift
//  SRT
//
//  Created by 박성민 on 12/14/24.
//

import SwiftUI

struct CompleteView: View {
    @StateObject private var viewModel: CompleteViewModel
    
    init(initialResultData: [String: Any], imageData: Data?) {
        _viewModel = StateObject(wrappedValue: CompleteViewModel(initialData: initialResultData, imageData: imageData))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // 데이터 표시
//            if let address = viewModel.resultData["address"] as? String {
//                Text("📍 주소: \(address)")
//                    .font(.headline)
//            }
//            if let report = viewModel.resultData["report"] as? String {
//                Text("📝 보고서: \(report)")
//                    .font(.body)
//            }
//            
//            if let latitude = viewModel.resultData["latitude"] as? Double{
//                Text("위도\(latitude)")
//            }
//            
//            if let longitude = viewModel.resultData["longitude"] as? Double{
//                Text("경도\(longitude)")
//            }
            Spacer()
        }
        .padding()
        .navigationTitle("결과 보기")
        .onAppear {
            viewModel.checkResultData()
        }
    }
}

#Preview {
    CompleteView(
        initialResultData: [
            "address": "봉양정보고등학교",
            "report": "봉양정보고 근처에서 어쩌고 저쩌고",
            "latitude": "35.123",
            "longitude": "1267.123"
        ],
        imageData: nil
    )
}
