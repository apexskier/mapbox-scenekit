import SceneKit

// temporary extension to use this class for color splines

internal extension SCNVector3 {
    func toRadius() -> CGFloat {
        return CGFloat(self.x)
    }
}

#if os(iOS)
internal extension SCNVector3 {
    func toColor() -> UIColor {
        return UIColor(red: CGFloat(self.x), green: CGFloat(self.y), blue: CGFloat(self.z), alpha: 1.0)
    }
}
#elseif os(macOS)
internal extension SCNVector3 {
    func toColor() -> NSColor {
        return NSColor(red: CGFloat(self.x), green: CGFloat(self.y), blue: CGFloat(self.z), alpha: 1.0)
    }
}
#endif
