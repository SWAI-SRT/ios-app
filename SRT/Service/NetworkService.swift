import Alamofire
import Foundation

class NetworkService {
    private static let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        return Session(configuration: configuration)
    }()

    static func sendCapturedData(_ captureData: PhotoCaptureData, completion: @escaping ([String: Any]) -> Void) {
        let url = "http://54.238.232.129:8000/detect"
        print("값 전송 완료")
        session.upload(
            multipartFormData: { formData in
                formData.append(captureData.imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                formData.append("\(captureData.latitude)".data(using: .utf8)!, withName: "lat")
                formData.append("\(captureData.longitude)".data(using: .utf8)!, withName: "lng")
            },
            to: url,
            method: .post,
            headers: ["ngrok-skip-browser-warning": "69420"]
        )
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    print("서버 응답 JSON: \(json)")
                    completion(json)
                } else {
                    print("JSON 파싱 실패, 더미 데이터 반환")
                    completion(dummyData())
                }
            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")
                print("더미 데이터 반환")
                completion(dummyData())
            }
        }
    }
    
    private static func dummyData() -> [String: Any] {
        return[
            "report":"봉양정보고 근처에서 어쩌고 저쩌고",
            "address": "봉양정보고등학교",
            "latitude": "35.123",
            "longitude": "1267.123"
        ]
    }
}
