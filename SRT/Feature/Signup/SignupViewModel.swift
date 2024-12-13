//
//  SignupViewModel.swift
//  SRT
//
//  Created by 박성민 on 9/22/24.
//

import Foundation
import Alamofire

class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    
    func signup() {
        print("password: \(password)")
        print("passwordCheck: \(passwordCheck)")
        
        if password != passwordCheck {
            print("비밀번호가 맞는지 확인해주세요")
            return
        }
        
        let url = "http://54.238.232.129:8080/auth/signup"
        let param: [String: Any] = [
            "nickName": name,
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
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        )
        .validate()
        .responseDecodable(of: SignupResponse.self) { response in
            switch response.result {
            case .success(let signupResponse):
                print("회원가입 성공: \(signupResponse.message)")
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
                if let data = response.data {
                    let errorMessage = String(data: data, encoding: .utf8)
                    print("서버 오류 응답: \(errorMessage ?? "없음")")
                }
            }
        }
    }
}
