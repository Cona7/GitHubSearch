import SwiftUI

struct DetailsButton: View {

    var title: String

    var body: some View {
        Text(title)
            .font(.body)
            .fontWeight(.semibold)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
            .background(Color("darkGreen"))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.all, 24)
    }
}

struct DetailsButton_Previews: PreviewProvider {
    static var previews: some View {
        DetailsButton(title: "Button text")
    }
}
