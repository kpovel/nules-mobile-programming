import Foundation

func writeEquationResults(xStart: Float, xEnd: Float, yStart: Float, yEnd: Float, step: Float) {
    var x = xStart;
    var y = yStart;
    var results = "";
    
    while x <= xEnd {
        y = yStart;
        while y <= yEnd {
            let result = solveEquation(x: x, y: y);
            results += "X = \(x), Y = \(y), Result = \(result)\n";
            y += Float(step);
        }
        x += Float(step);
    }
    
    let filePath = try! FileManager
        .default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent("output");
    try! results.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
}

func solveEquation (x: Float, y: Float) -> Float {
    let numerator = log(2.33) * (1 + pow(cos(y), 2)).squareRoot();
    let denominator = pow(exp(1.0), y) + pow(sin(x), 2);
    return numerator / denominator;
}
