//
//  EdgeInsets.swift
//  MapboxSceneKit
//
//  Created by Cameron Little on 2/5/20.
//  Copyright © 2020 MapBox. All rights reserved.
//

import Foundation

protocol EdgeInsets {
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    var bottom: CGFloat { get }
    var left: CGFloat { get }
    var right: CGFloat { get }
    var top: CGFloat { get }
}

#if os(iOS)
import UIKit

extension UIEdgeInsets: EdgeInsets {}
#elseif os(macOS)
import Cocoa

extension NSEdgeInsets: EdgeInsets {}
#endif
