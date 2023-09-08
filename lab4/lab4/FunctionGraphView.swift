import SwiftUI

struct FunctionGraphView: View {
    @State private var dataPoints: [(x: Float, y: Float, result: Float)] = []
    
    var body: some View {
        VStack {
            Button("Load Data") {
                dataPoints = fetchData()
            }
            .padding()
            
            GraphView(dataPoints: dataPoints)
        }
    }
}

struct GraphView: View {
    var dataPoints: [(x: Float, y: Float, result: Float)]
    
    var minX: Float { dataPoints.map { $0.x }.min() ?? 0 }
    var maxX: Float { dataPoints.map { $0.x }.max() ?? 0 }
    var minY: Float { dataPoints.map { $0.result }.min() ?? 0 }
    var maxY: Float { dataPoints.map { $0.result }.max() ?? 0 }
    
    var xRange: Float { maxX - minX }
    var yRange: Float { maxY - minY }
    
    func normalizedPoint(from point: (x: Float, y: Float, result: Float), in size: CGSize) -> CGPoint {
        let x = CGFloat((point.x - minX) / xRange) * size.width
        let y = size.height - CGFloat((point.result - minY) / yRange) * size.height
        return CGPoint(x: x, y: y)
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                guard let firstPoint = dataPoints.first else { return }
                
                let start = normalizedPoint(from: firstPoint, in: geometry.size)
                path.move(to: start)
                
                for point in dataPoints {
                    let next = normalizedPoint(from: point, in: geometry.size)
                    path.addLine(to: next)
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}





struct FunctionGraphView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionGraphView()
    }
}
