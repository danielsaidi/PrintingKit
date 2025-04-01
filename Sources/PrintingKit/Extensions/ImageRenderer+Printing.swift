//
//  ImageRenderer+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@MainActor
@available(iOS 16.0, macOS 13.0, *)
extension ImageRenderer {
    
    /// Get image data that can be used to print the image.
    var imageData: Data? {
        #if os(iOS) || os(visionOS)
        uiImage?.standardPrintData
        #elseif os(macOS)
        nsImage?.standardPrintData
        #else
        nil
        #endif
    }
}
