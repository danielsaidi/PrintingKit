//
//  PdfDataSource.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used to generate PDF data.
public protocol PdfDataSource {
    
    /// Generate PDF data.
    func pdfData() throws -> Data

    /// Generate PDF data for the provided configuration.
    func pdfData(
        withConfiguration config: Pdf.PageConfiguration
    ) throws -> Data
}
