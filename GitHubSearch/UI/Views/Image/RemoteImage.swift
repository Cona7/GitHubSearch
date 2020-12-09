import SwiftUI
import SDWebImage

final class ImageLoader: ObservableObject {
    @Published var image: Image?

    func load(fromURLString urlString: String) {

        guard let url = URL(string: urlString) else {
            return
        }

        SDWebImageManager
            .shared
            .loadImage(with: url, options: SDWebImageOptions.continueInBackground, progress: nil) { image, _, _, _, _, _  in
                if let image = image {
                    self.image = Image(uiImage: image)
                }
        }
    }
}

struct RemoteImage: View {
    var image: Image?

    var body: some View {
        image?.resizable() ?? Image("GitHub-Mark").resizable()
    }
}

struct DetailsRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()

    @Binding var urlString: String

    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onChange(of: urlString) { _ in
                imageLoader.load(fromURLString: urlString)
            }
    }
}
