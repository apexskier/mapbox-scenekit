import Foundation
#if os(iOS)
import UIKit
#endif

internal func * (left: CGFloat, right: Float) -> CGFloat {
    return left * CGFloat(right)
}

internal func / (left: CGFloat, right: Float) -> CGFloat {
    return left / CGFloat(right)
}
