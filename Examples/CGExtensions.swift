import Foundation

internal func * (left: CGFloat, right: Float) -> CGFloat {
    return left * CGFloat(right)
}

internal func / (left: CGFloat, right: Float) -> CGFloat {
    return left / CGFloat(right)
}
