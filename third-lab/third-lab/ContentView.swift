import SwiftUI
import Combine

struct ContentView: View {
    @State private var xStart = "";
    @State private var xEnd = "";
    @State private var yStart = "";
    @State private var yEnd = "";
    @State private var step: Float = 0.1;
    @State private var result: String = "";
    @State private var showResult = false;
    
    var body: some View {
        ScrollView {
            Text("Laboratory work No 3")
                .font(.title)
                .fontWeight(.bold)
            Image("equation")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical)
                
            VStack (alignment: .leading) {
                Text("X start")
                    .font(.headline)
                TextField(
                    "Type the start of \"x\"",
                    text: $xStart
                )
                .onReceive(Just(xStart)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.xStart = filtered
                    }
                }
            .textFieldStyle(.roundedBorder)
            }
            VStack (alignment: .leading) {
                Text("X end")
                    .font(.headline)
                TextField(
                    "Type the end of \"x\"",
                    text: $xEnd
                )
                .onReceive(Just(xEnd)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.xEnd = filtered
                    }
                }
            .textFieldStyle(.roundedBorder)
            }
            
            VStack (alignment: .leading) {
                Text("Y start")
                    .font(.headline)
                
                TextField(
                    "Type the start of \"y\"",
                    text: $yStart
                )
                .onReceive(Just(yStart)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.yStart = filtered
                    }
                }
                .textFieldStyle(.roundedBorder)
            }
            VStack (alignment: .leading) {
                Text("Y end")
                    .font(.headline)
                
                TextField(
                    "Type the end of \"y\"",
                    text: $yEnd
                )
                .onReceive(Just(yEnd)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.yEnd = filtered
                    }
                }
                .textFieldStyle(.roundedBorder)
            }
            VStack (alignment: .leading) {
                Text("Selected step \(String(format: "%.1f", step))")
                    .font(.headline)
                
                Slider(value: $step, in: 0.1...1.0, step: 0.1)
                    .padding()
            }
            
            Button("Solve the equation") {
                writeEquationResults(xStart: (xStart as NSString).floatValue, xEnd: (xEnd as NSString).floatValue, yStart: (yStart as NSString).floatValue, yEnd: (yEnd as NSString).floatValue, step: step)
                
                let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("output")
                result = try! String(contentsOf: filePath)
                showResult = true;
            }
            .padding(.top)
            .fontWeight(.medium)
            
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
