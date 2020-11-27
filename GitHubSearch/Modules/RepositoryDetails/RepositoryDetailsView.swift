import SwiftUI

struct RepositoryDetailsView: View {

    @ObservedObject var viewModel: RepositoryDetailsViewModel
    @State var isShowingSafariView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 15) {
                    DetailsRemoteImage(urlString: $viewModel.ownerAvatarURL)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(viewModel.ownerName)
                            .font(.title)
                            .fontWeight(.medium)

                        Text(viewModel.ownerType)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }

                    Spacer()
                }

                VStack(spacing: 5) {
                    HStack {
                        Text(viewModel.description)
                            .font(.body)
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                        Spacer()
                    }

                    BodyDetailsView(title: "Programming Language", value: viewModel.programmingLanguage)
                    BodyDetailsView(title: "Created", value: viewModel.createdAt)
                    BodyDetailsView(title: "Updated", value: viewModel.updatedAt)
                }

                Spacer()

                Button {
                    isShowingSafariView = true
                } label: {
                    DetailsButton(title: "More details")
                }
            }
            .padding(.horizontal, 24)
            .navigationTitle(viewModel.name)
        }
        .fullScreenCover(isPresented: $isShowingSafariView ) {
            SafariView(url: viewModel.repoUrl!)
        }
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(name: "GitHubSearch", owner: "Cona7"))
    }
}

struct BodyDetailsView: View {

    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title).font(.body)
            Spacer()
            Text(value).font(.body)
        }
    }
}
