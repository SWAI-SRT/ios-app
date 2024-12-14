import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var completion: ((Double, Double) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func fetchCurrentLocation(completion: @escaping (Double, Double) -> Void) {
        self.completion = completion
        handleAuthorizationStatus(locationManager.authorizationStatus)
    }
    
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        DispatchQueue.global(qos: .background).async {
                switch status {
                case .notDetermined:
                    // 메인 스레드로 권한 요청
                    DispatchQueue.main.async {
                        self.locationManager.requestWhenInUseAuthorization()
                    }
                case .authorizedWhenInUse, .authorizedAlways:
                    // 위치 업데이트를 백그라운드 스레드에서 시작
                    print("권한이 허용됨: 위치 업데이트 시작")
                    self.locationManager.startUpdatingLocation()
                case .denied, .restricted:
                    print("위치 권한이 거부되거나 제한됨")
                    self.completion = nil
                @unknown default:
                    print("알 수 없는 권한 상태")
                    self.completion = nil
                }
            }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatus(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            DispatchQueue.main.async {
                self.completion?(location.coordinate.latitude, location.coordinate.longitude)
                self.completion = nil
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        DispatchQueue.main.async { 
            self.completion = nil
        }
    }
}
