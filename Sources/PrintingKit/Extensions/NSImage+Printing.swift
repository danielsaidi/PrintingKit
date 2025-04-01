//
//  NSImage+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

#if os(macOS)
import AppKit

public extension NSImage {
    
    /// Get JPEG data from the image.
    func jpegData(compressionQuality: CGFloat) -> Data? {
        guard let image = cgImage(forProposedRect: nil, context: nil, hints: nil) else { return nil }
        let bitmap = NSBitmapImageRep(cgImage: image)
        return bitmap.representation(using: .jpeg, properties: [.compressionFactor: compressionQuality])
    }
}
#endif
