import SwiftUI
import Combine

struct ContentView: View {
    @State private var firstArgument = "";
    @State private var secondArgument = "";
    @State private var showResult = false;
    @State private var result: Float = 0;
    
    var body: some View {
        VStack {
            Text("Laboratory work No. 2")
                .font(.title)
                .fontWeight(.bold)
            TextField(
                "Type the \"x\" argument for the equation",
                text: $firstArgument
            )
            .onReceive(Just(firstArgument)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.firstArgument = filtered
                }
            }
            .textFieldStyle(.roundedBorder)
            
            TextField(
                "Type the \"y\" argument for the equation",
                text: $secondArgument
            )
            .onReceive(Just(secondArgument)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.secondArgument = filtered
                }
            }
            .textFieldStyle(.roundedBorder)
            Button("Solve the equation") {
                result = solveEquation(x: (firstArgument as NSString).floatValue, y: (secondArgument as NSString).floatValue);
                showResult = true;
            }
            .padding(.top)
            .fontWeight(.medium)
            
            Image("equation")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical)
            
            if showResult {
                Text("I = \(result)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top)
            }
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
