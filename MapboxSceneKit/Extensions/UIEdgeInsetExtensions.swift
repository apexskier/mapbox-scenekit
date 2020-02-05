import Foundation
import UIKit

internal func * (left: UIEdgeInsets, right: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: left.top * right, left: left.left * right, bottom: left.bottom * right, right: left.right * right)
}

internal func *= (left: inout UIEdgeInsets, right: CGFloat) {
    left = left * right
}

