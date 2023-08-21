//
//  Pdf+PageMargins.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension Pdf {
    
    /**
     This struct defines a PDF document's page margins.
     */
    struct PageMargins: Equatable {
        
        /**
         Create a PDF document page margins value.
         
         - Parameters:
           - top: The top margins.
           - left: The left margins.
           - bottom: The bottom margins.
           - right: The right margins.
         */
        public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
        
        /**
         Create PDF page margins.
         
         - Parameters:
           - horizontal: The horizontal margins.
           - vertical: The vertical margins.
         */
        public init(horizontal: CGFloat, vertical: CGFloat) {
            self.top = vertical
            self.left = horizontal
            self.bottom = vertical
            self.right = horizontal
        }
        
        /**
         Create PDF page margins.
         
         - Parameters:
           - all: The margins for all edges.
         */
        public init(all: CGFloat) {
            self.top = all
            self.left = all
            self.bottom = all
            self.right = all
        }
        
        /// The top margins.
        public var top: CGFloat
        
        /// The left margins.
        public var left: CGFloat
        
        /// The bottom margins.
        public var bottom: CGFloat
        
        /// The right margins.
        public var right: CGFloat
    }
}
