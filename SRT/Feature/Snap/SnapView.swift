import SwiftUI
import AVFoundation

struct SnapView: View {
    @StateObject private var camera = CameraModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let locationManager = LocationManager()
    
    @State private var showCapturedImage = false
    @State private var capturedData: PhotoCaptureData?
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 15, height: 30)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30)
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(width: 400, height: 450)
                        .foregroundColor(.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    CameraPreviewLayer(session: camera.session)
                        .frame(height: 400)
                        .cornerRadius(10)
                        .onAppear {
                            camera.checkPermissions()
                        }
                }
                
                Spacer()
                
                Button(action: capturePhoto) {
                    Image("SRTLogo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                        .padding()
                }
                
                NavigationLink(
                    destination: CapturedImageView(imageData: capturedData?.imageData ?? Data()),
                    isActive: $showCapturedImage,
                    label: { EmptyView() }
                )
            }
            .background(Color.white.ignoresSafeArea())
            .alert(isPresented: $camera.alert) {
                Alert(title: Text("카메라 접근 거부"),
                      message: Text("설정에서 카메라 접근 권한을 허용해주세요."),
                      dismissButton: .default(Text("확인")))
            }
        }
    }
    
    private func capturePhoto() {
        camera.takePicture()
        locationManager.fetchCurrentLocation { latitude, longitude in
            if let imageData = camera.photoData {
                let captureData = PhotoCaptureData(imageData: imageData, latitude: latitude, longitude: longitude)
                NetworkService.sendCapturedData(captureData)
                self.capturedData = captureData
                self.showCapturedImage = true
            }
        }
    }
}

struct CameraPreviewLayer: UIViewRepresentable {
    var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct SnapView_Previews: PreviewProvider {
    static var previews: some View {
        SnapView()
    }
}
