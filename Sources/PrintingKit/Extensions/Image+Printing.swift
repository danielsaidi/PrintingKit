//
//  Image+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

public typealias PrintableImage = UIImage

public extension UIImage {
    
    /// Get the image's standard print data.
    var standardPrintData: Data? {
        pngData()
    }
}
#elseif os(macOS)
import AppKit

public typealias PrintableImage = NSImage

public extension NSImage {
    
    /// Get the image's standard print data.
    var standardPrintData: Data? {
        jpegData(compressionQuality: 1)
    }
    
    /// Get JPEG data from the image.
    func jpegData(compressionQuality: CGFloat) -> Data? {
        guard let image = cgImage(forProposedRect: nil, context: nil, hints: nil) else { return nil }
        let bitmap = NSBitmapImageRep(cgImage: image)
        return bitmap.representation(using: .jpeg, properties: [.compressionFactor: compressionQuality])
    }
}
#endif
