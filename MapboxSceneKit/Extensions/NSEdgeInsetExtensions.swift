import Cocoa

internal func * (left: NSEdgeInsets, right: CGFloat) -> NSEdgeInsets {
    return NSEdgeInsets(top: left.top * right, left: left.left * right, bottom: left.bottom * right, right: left.right * right)
}

internal func *= (left: inout NSEdgeInsets, right: CGFloat) {
    left = left * right
}

