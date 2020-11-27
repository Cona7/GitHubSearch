import SwiftUI
import SDWebImage

struct DetailsView: View {

    @ObservedObject var viewModel: DetailsViewModel2
    @State var isShowingSafariView = false

    var body: some View {
        VStack {
            DetailsRemoteImage(urlString: $viewModel.avatarURL)

            VStack(spacing: 5) {
                Text(viewModel.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)

                Text(viewModel.type)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 24)

                HStack(alignment: .center, spacing: 20) {
                    UserDetailsView(title: "Followers", value: viewModel.followers)
                    UserDetailsView(title: "Following", value: viewModel.following)
                    UserDetailsView(title: "Repositories", value: viewModel.repositories)
                }

                Spacer()

                Button {
                    if viewModel.ownerUrl != nil {
                        isShowingSafariView = true
                    }
                } label: {
                    DetailsButton(title: "More details")
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingSafariView ) {
            SafariView(url: viewModel.ownerUrl!)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel2(name: "Cona7"))
    }
}

struct UserDetailsView: View {

    var title: String
    var value: String

    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.title3)
                .bold()

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .italic()
        }
    }
}
