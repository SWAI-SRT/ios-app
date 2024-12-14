import Foundation
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var photoData: Data?
    
    private var output = AVCapturePhotoOutput()
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUpSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.setUpSession()
                    } else {
                        self?.alert = true
                    }
                }
            }
        default:
            DispatchQueue.main.async {
                self.alert = true
            }
        }
    }
    
    private func setUpSession() {
        DispatchQueue.global(qos: .background).async {
            do {
                self.session.beginConfiguration()
                
                guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                    print("No camera found.")
                    return
                }
                
                let input = try AVCaptureDeviceInput(device: device)
                if self.session.canAddInput(input) {
                    self.session.addInput(input)
                }
                
                if self.session.canAddOutput(self.output) {
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
                self.session.startRunning() // 백그라운드 스레드에서 호출
            } catch {
                print("Camera setup error: \(error.localizedDescription)")
            }
        }
    }

    
    func takePicture(completion: @escaping (Data) -> Void) {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        output.capturePhoto(with: settings, delegate: self)
        self.photoCompletion = completion
    }
    
    private var photoCompletion: ((Data) -> Void)?
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(), error == nil else {
            print("Photo capture error: \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        DispatchQueue.main.async {
            self.photoCompletion?(imageData)
            self.photoData = imageData
        }
    }
}
