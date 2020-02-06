#if os(macOS)
import Cocoa

typealias Color = NSColor

extension Color {
    convenience init(white: CGFloat, alpha: CGFloat) {
        self.init(deviceWhite: white, alpha: alpha)
    }
}
#elseif os(iOS)
import UIKit

typealias Color = UIColor
#endif
