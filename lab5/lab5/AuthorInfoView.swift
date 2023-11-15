import Foundation
import SwiftUI
import PhotosUI

struct AuthorInfoView: View {
    var body: some View {
        VStack {
            Text("Author Info")
                .font(.title)
            Text("Name: Pavlo Karas")
            Image("me")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
        }
        .padding()
    }
}
