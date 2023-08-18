import Foundation

func solveEquation (x: Float, y: Float) -> Float {
    let numerator = log(2.33) * (1 + pow(cos(y), 2)).squareRoot();
    let denominator = pow(exp(1.0), y) + pow(sin(x), 2);
    return numerator / denominator;
}
