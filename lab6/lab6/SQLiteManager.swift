import SQLite3
import Foundation

class SQLiteManager {
    var db: OpaquePointer?
    
    init() {
        openDatabase()
        createTable()
        insertInitialData()
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("UkraineCities.sqlite")
        
        print(fileURL)
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    func createTable() {
        let createTableString = """
        create table if not exists cities(
            id integer primary key autoincrement,
            name text,
            distance_to_kyiv integer,
            number_of_inhabitants integer
        );
        """
        if sqlite3_exec(db, createTableString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertInitialData() {
        let countStatementString = "SELECT count(*) FROM Cities;"
        var countStatement: OpaquePointer?
        var recordCount: Int32 = 0
        
        if sqlite3_prepare_v2(db, countStatementString, -1, &countStatement, nil) == SQLITE_OK {
            if sqlite3_step(countStatement) == SQLITE_ROW {
                recordCount = sqlite3_column_int(countStatement, 0)
            }
        }
        sqlite3_finalize(countStatement)
        
        if recordCount == 0 {
            for city in cities {
                insert(city: City(id: 0, name: city.0, distanceToKyiv: city.1, numberOfInhabitants: city.2))
            }
        }
    }
    
    func insert(city: City) {
        let insertStatementString = "INSERT INTO Cities (name, distance_to_kyiv, number_of_inhabitants) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (city.name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(city.distanceToKyiv))
            sqlite3_bind_int(insertStatement, 3, Int32(city.numberOfInhabitants))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\(city.name) successfully inserted.")
            } else {
                print("Could not insert \(city.name).")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func fetchCities() -> [City] {
        let queryStatementString = "select * from cities;"
        var queryStatement: OpaquePointer?
        var cities : [City] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let distance = Int(sqlite3_column_int(queryStatement, 2))
                let population = Int(sqlite3_column_int(queryStatement, 3))
                cities.append(City(id: id, name: name, distanceToKyiv: distance, numberOfInhabitants: population))
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("SELECT statement could not be prepared: \(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return cities
    }
    
    func manyInhabitants() -> [City] {
        let queryStatementString = "select * from cities where number_of_inhabitants > 500000;";
        var queryStatement: OpaquePointer?
        var cities : [City] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let distance = Int(sqlite3_column_int(queryStatement, 2))
                let population = Int(sqlite3_column_int(queryStatement, 3))
                cities.append(City(id: id, name: name, distanceToKyiv: distance, numberOfInhabitants: population))
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("SELECT statement could not be prepared: \(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return cities
    }
    
    func maxMinDistanceToKyiv() -> [City] {
        let queryStatementString = """
        SELECT *
                FROM cities
                WHERE distance_to_kyiv = (SELECT MAX(distance_to_kyiv) FROM cities)
                OR distance_to_kyiv = (SELECT MIN(distance_to_kyiv) FROM cities WHERE distance_to_kyiv > 0);
        """;
        var queryStatement: OpaquePointer?
        var cities : [City] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let distance = Int(sqlite3_column_int(queryStatement, 2))
                let population = Int(sqlite3_column_int(queryStatement, 3))
                cities.append(City(id: id, name: name, distanceToKyiv: distance, numberOfInhabitants: population))
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("SELECT statement could not be prepared: \(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return cities
    }
}
