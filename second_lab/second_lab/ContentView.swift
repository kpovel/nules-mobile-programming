import SwiftUI
import Combine

struct ContentView: View {
    @State private var firstArgument = "";
    var body: some View {
        VStack {
            Text("Laboratory work No. 2")
                .font(.title)
                .fontWeight(.bold)
            TextField(
                "Enter the first argument of the equation",
                text: $firstArgument
            )
            .onReceive(Just(firstArgument)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.firstArgument = filtered
                }
            }
            .textFieldStyle(.roundedBorder)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
