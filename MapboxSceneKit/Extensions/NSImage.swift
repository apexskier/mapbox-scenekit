//
//  NSImage.swift
//  MapboxSceneKit
//
//  Created by Cameron Little on 2/5/20.
//  Copyright © 2020 MapBox. All rights reserved.
//

import Cocoa

extension NSImage {
    var cgImage: CGImage? {
        var imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        return self.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
    }
}
