//
//  Image+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(visionOS)
import UIKit

public typealias PrintableImage = UIImage

public extension UIImage {
    
    /// Get the standard print data for an image.
    var standardPrintData: Data? {
        pngData()
    }
}
#elseif os(macOS)
import AppKit

public typealias PrintableImage = NSImage

public extension NSImage {
    
    var standardPrintData: Data? {
        jpegData(compressionQuality: 1)
    }
}
#endif
