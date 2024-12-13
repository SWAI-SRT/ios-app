import SwiftUI

struct CapturedImageView: View {
    var imageData: Data

    var body: some View {
        VStack {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .navigationBarTitle("촬영된 사진", displayMode: .inline)
            } else {
                Text("이미지를 불러올 수 없습니다.")
                    .foregroundColor(.red)
            }
        }
        .background(Color.white)
    }
}
#Preview {
    CapturedImageView(imageData: .init(count: 100))
}
