import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FunctionValuesView()
                .tabItem {
                    Label("Function Values", systemImage: "list.dash")
                }
                .tag(0)
            
            FunctionGraphView()
                .tabItem {
                    Label("Function Graph", systemImage: "waveform.path.ecg")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
