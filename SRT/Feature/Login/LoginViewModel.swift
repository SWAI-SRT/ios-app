//
//  LoginViewModel.swift
//  SRT
//
//  Created by 박성민 on 9/20/24.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class LoginViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var loginOK : Bool = false
    
    func signin() {
        let url = "http://54.238.232.129:8080/auth/signin"
        
//        if(email == ""){
//            alertMessage = "이메일을 입력하세요"
//            showAlert.toggle()
//            return;
//        }
//        
//        if(password == ""){
//            alertMessage = "비밀번호를 입력하세요"
//            showAlert.toggle()
//            return;
//        }
        
        let param: [String:Any] = [
            "email": email,
            "password": password
        ]
        
        print(param)
        
        AF.request(
            url,
            method: .post,
            parameters: param,
            encoding: JSONEncoding.default,
            headers: [
                "Content-Type": "application/json"
            ]
        )
        .validate()
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                print("로그인 성공")
                KeychainWrapper.standard.set(loginResponse.accessToken, forKey: "authorization")
                KeychainWrapper.standard.set(loginResponse.refreshToken, forKey: "refreshToken")
                
                print("Message: \(loginResponse.message)")
                
                self.loginOK = true
                
            case .failure(let error):
                print("로그인 실패: \(error.localizedDescription)")
                self.alertMessage = "로그인에 실패하였습니다."
                self.showAlert.toggle()
                if let data = response.data,
                   let errorMessage = String(data: data, encoding: .utf8) {
                    print("서버 에러 메시지: \(errorMessage)")
                }
            }
        }
    }
        
    func tokenCheck() {
        print("토큰 체크")
        let token = KeychainWrapper.standard.string(forKey: "authorization")
        
        let url = "http://43.203.199.146:8080/auth/me"
        
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: ["Authorization": "Bearer \(token)"]
        )
        .validate()
        .response { response in
            switch response.result{
            case .success(let data):
                print("로그인 성공")
                
            case .failure(let error):
                print("로그인 실패")
            }
        }
    }
}
