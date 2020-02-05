import Foundation

internal func * (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

internal func * (left: CGFloat, right: Float) -> CGFloat {
    return left * CGFloat(right)
}

internal func / (left: CGFloat, right: Float) -> CGFloat {
    return left / CGFloat(right)
}

internal func *= (left: inout CGSize, right: CGFloat) {
    left = left * right
}

internal extension CGImage {
    var size: CGSize {
        CGSize(width: self.width, height: self.height)
    }
}
