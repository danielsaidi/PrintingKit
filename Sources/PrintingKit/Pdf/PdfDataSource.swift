//
//  PdfDataSource.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can generate PDF data.
public protocol PdfDataSource {
    
    /// Generate PDF data.
    func pdfData() throws -> Data

    /// Generate PDF data for the provided configuration.
    func pdfData(
        withConfiguration config: Printer.PageConfiguration
    ) throws -> Data
}
