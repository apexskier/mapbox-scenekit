import Foundation
#if os(macOS)
import Cocoa
#endif

internal final class ImageBuilder {
    private let context: CGContext?
    private let clippedRect: CGRect
    private let tileSize: CGSize
    private let imageSize: CGSize
    private let compositingDispatchQueue = DispatchQueue(label: "com.mapbox.SceneKit.compositing", attributes: .concurrent)

    init(xs: Int, ys: Int, tileSize: CGSize, insets: EdgeInsets) {
        self.imageSize = CGSize(width: CGFloat(xs) * tileSize.width, height: CGFloat(ys) * tileSize.height)
        let finalSize = CGSize(width: imageSize.width - insets.left - insets.right,
                               height: imageSize.height - insets.top - insets.bottom)
        self.clippedRect = CGRect(x: insets.left, y: insets.top, width: finalSize.width, height: finalSize.height)
        self.tileSize = tileSize
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        context = CGContext(data: nil, width: Int(imageSize.width), height: Int(imageSize.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        if context == nil {
            NSLog("Error creating CGContext")
        }
    }

    #if os(iOS)
    func addTile(x: Int, y: Int, image: UIImage) {
        compositingDispatchQueue.sync(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            guard let cgImage = image.cgImage else { return }

            context?.draw(cgImage, in: CGRect(origin: CGPoint(x: CGFloat(x) * self.tileSize.width, y: CGFloat(Int(self.imageSize.height / self.tileSize.height) - y - 1) * self.tileSize.height), size: self.tileSize))
        }
    }

    func makeImage() -> UIImage? {
        if let cgImage = context?.makeImage()?.cropping(to: clippedRect) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    #elseif os(macOS)
    func addTile(x: Int, y: Int, image: NSImage) {
        compositingDispatchQueue.sync(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            
            var rect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
            guard let cgImage = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) else { return }
            context?.draw(cgImage, in: CGRect(origin: CGPoint(x: CGFloat(x) * self.tileSize.width, y: CGFloat(Int(self.imageSize.height / self.tileSize.height) - y - 1) * self.tileSize.height), size: self.tileSize))
        }
    }
    
    func makeImage() -> NSImage? {
        if let cgImage = context?.makeImage()?.cropping(to: clippedRect) {
            return NSImage(cgImage: cgImage, size: imageSize)
        }
        return nil
    }
    #endif
}
