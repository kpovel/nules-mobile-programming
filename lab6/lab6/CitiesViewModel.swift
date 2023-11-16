import Foundation

class CitiesViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var numberOfInhabitants: [City] = [];
    @Published var maxMinDistanceToKyiv: [City] = [];
    
    private var sqliteManager = SQLiteManager()
    
    init() {
        fetchCities()
        maxMinDistance()
        fetchNumberOfInhabitants()
    }
    
    func fetchCities() {
        self.cities = sqliteManager.fetchCities()
    }
    
    func fetchNumberOfInhabitants() {
        self.numberOfInhabitants = sqliteManager.manyInhabitants()
    }
    
    func maxMinDistance() {
        self.maxMinDistanceToKyiv = sqliteManager.maxMinDistanceToKyiv()
    }
}
