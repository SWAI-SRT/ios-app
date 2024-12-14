//
//  CompleteViewModel.swift
//  SRT
//
//  Created by 박성민 on 12/14/24.
//

import Foundation

class CompleteViewModel: ObservableObject{
    @Published var resultData: [String:Any] = [:]
    @Published var imageData: Data?
    
    init(initialData: [String:Any], imageData: Data?) {
        self.resultData = initialData
        self.imageData = imageData
    }
    
    func checkResultData() {
        print(resultData)
    }
}
