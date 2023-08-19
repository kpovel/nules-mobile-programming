import SwiftUI

struct AboutMe: View {
    @State private var showMe = false;
    var body: some View {
        VStack {
            Divider()
                .padding()
            Button("Show about me information") {
                showMe.toggle()
            }
            if showMe {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Виконав: ")
                        Text("Карась Павло Петрович")
                    }
                    HStack {
                        Text("Факультет: ")
                        Text("Інформаційних технологій")
                    }
                    HStack {
                        Text("Курс: ")
                        Text("3")
                    }
                    HStack {
                        Text("Група: ")
                        Text("ІПЗ-21007б")
                    }
                    Image("me")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                }
                .padding()
            }
        }
    }
}

struct AboutMe_Previews: PreviewProvider {
    static var previews: some View {
        AboutMe()
    }
}
