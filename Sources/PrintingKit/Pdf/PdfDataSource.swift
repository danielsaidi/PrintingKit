//
//  PdfDataSource.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can generate
 PDF data.

 The protocol is implemented by `NSAttributedString` as well
 as other types in the library.
 */
public protocol PdfDataSource {
    
    /// Generate PDF data.
    func pdfData() throws -> Data
    
    /// Generate PDF data for the provided configuration.
    func pdfData(
        withConfiguration config: Pdf.PageConfiguration
    ) throws -> Data
}
