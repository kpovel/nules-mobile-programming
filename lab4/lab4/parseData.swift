import Foundation

func fetchData() -> [(x: Float, y: Float, result: Float)] {
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("output")
    
    do {
        let fileContent = try String(contentsOf: filePath)
        return parseData(content: fileContent)
    } catch {
        print("Error reading file: \(error)")
        return []
    }
}

func parseData(content: String) -> [(x: Float, y: Float, result: Float)] {
    let lines = content.split(separator: "\n")
    
    return lines.compactMap { line in
        let components = line.split(separator: ",")
        
        if components.count >= 3,
           let xVal = components[0].split(separator: "=").last?.trimmingCharacters(in: .whitespacesAndNewlines),
           let yVal = components[1].split(separator: "=").last?.trimmingCharacters(in: .whitespacesAndNewlines),
           let resultVal = components[2].split(separator: "=").last?.trimmingCharacters(in: .whitespacesAndNewlines),
           let x = Float(xVal),
           let y = Float(yVal),
           let result = Float(resultVal) {
            return (x: x, y: y, result: result)
        }
        
        return nil
    }
}
