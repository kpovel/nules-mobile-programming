import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CitiesViewModel()
    
    var body: some View {
        TabView {
            List(viewModel.cities) { city in
                CityView(city: city)
            }
            .tabItem {
                Label("All Cities", systemImage: "building.2")
            }
            .onAppear {
                viewModel.fetchCities()
            }
            
            List(viewModel.numberOfInhabitants) {city in
                CityView(city: city)
            }
            .tabItem {
                Label("Huge Popularity", systemImage: "building.2.crop.circle.fill")
            }
            .onAppear {
                viewModel.fetchNumberOfInhabitants()
            }
            
            List(viewModel.maxMinDistanceToKyiv) { city in
                CityView(city: city)
            }
            .tabItem {
                Label("Max/Min Distance", systemImage: "arrow.left.and.right")
            }
            .onAppear {
                viewModel.maxMinDistance()
            }
        }
    }
}

// A reusable view for displaying a city
struct CityView: View {
    var city: City
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(city.name).font(.headline)
            Text("Distance to Kyiv: \(city.distanceToKyiv) km")
            Text("Population: \(city.numberOfInhabitants)")
        }
    }
}

#Preview {
    ContentView()
}
