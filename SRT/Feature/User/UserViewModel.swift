//
//  UserViewModel.swift
//  SRT
//
//  Created by 박성민 on 11/18/24.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class UserViewModel: ObservableObject {
    @Published var nickName: String = ""
    @Published var newNickName: String = ""
    @Published var email: String = ""
    
    var onDismiss: (() -> Void)?
    
    let url = "http://54.238.232.129:8080/auth/me"
    
    func getUser() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("Access token not found in Keychain")
            return
        }
        
        print("Access token: \(token)")
        
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: ["authorization": "Bearer \(token)"]
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.email = user.email
                        self.nickName = user.nickName
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func fetchUser() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("Access token not found in Keychain")
            return
        }
        
        let param: [String: Any] = [
            "nickName" : newNickName,
            "email" : email
        ]
        
        print("Access Token: \(token)")
        
        AF.request(
            url,
            method: .patch,
            parameters: param,
            encoding: JSONEncoding.default,
            headers: ["Authorization": "Bearer \(token)"]
        )
        .validate()
        .responseData{ response in
            switch(response.result){
            case .success(let data):
                print("로그인 성공")
                print(data)
                DispatchQueue.main.async {
                    self.onDismiss?()
                }
                                
            case .failure(let error):
                print("로그인 실패")
                print(error)
            }
        }
    }
}
