//
//  Pdf+PageConfiguration.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension Pdf {
    
    /**
     This struct defines a PDF document's page configuration.
     */
    struct PageConfiguration: Equatable {
        
        /**
         Create a PDF document page configuration value.
         
         - Parameters:
           - pageSize: The page size in points.
           - pageMargins: The page margins, by default `72`.
         */
        public init(
            pageSize: CGSize = CGSize(width: 595.2, height: 841.8),
            pageMargins: PageMargins = .init(all: 72)
        ) {
            self.pageSize = pageSize
            self.pageMargins = pageMargins
        }
        
        /// The page size in points.
        public var pageSize: CGSize
        
        /// The page margins, by default `72`.
        public var pageMargins: PageMargins
    }
}

public extension Pdf.PageConfiguration {

    /**
     The standard PDF page configuration.

     You can override this value to change the global config.
     */
    static var standard = Self()
}

public extension Pdf.PageConfiguration {

    /// Get the configuration's paper rectangle.
    var paperRect: CGRect {
        CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
    }

    /// Get the configuration's printable rectangle.
    var printableRect: CGRect {
        CGRect(
            x: pageMargins.left,
            y: pageMargins.top,
            width: pageSize.width - pageMargins.left - pageMargins.right,
            height: pageSize.height - pageMargins.top - pageMargins.bottom
        )
    }
}
