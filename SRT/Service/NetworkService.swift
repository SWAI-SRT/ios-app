//
//  NetworkService.swift
//  SRT
//
//  Created by 박성민 on 11/19/24.
//

import Alamofire
import Foundation

class NetworkService {
    static func sendCapturedData(_ captureData: PhotoCaptureData) {
        let url = "http://54.238.232.129:8000/detect"
        AF.upload(
            multipartFormData: { formData in
                formData.append(captureData.imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                formData.append("\(captureData.latitude)".data(using: .utf8)!, withName: "lat")
                formData.append("\(captureData.longitude)".data(using: .utf8)!, withName: "lng")
            },
            to: url,
            method: .post,
            headers: ["ngrok-skip-browser-warning":"69420"]
        )
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    if let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)")
                    } else {
                        print("Unable to decode response to UTF-8 string")
                    }
                }
                print("Upload successful!")
            case .failure(let error):
                print("Upload failed: \(error.localizedDescription)")
            }
        }
    }
}
