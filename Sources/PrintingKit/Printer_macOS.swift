//
//  StandardPrinter.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(macOS)
import AppKit
import PDFKit

/**
 This class implements the ``Printer`` protocol for macOS.
 
 This class uses a `AppKit` and `PDFKit` to perform printing.
 */
public class StandardPrinter: Printer {
    
    public init() {}
    
    public func canPrint(_ item: PrintItem) -> Bool {
        switch item {
        case .attributedString: return true
        case .imageData: return canPrintImages
        case .imageFile: return canPrintImages
        case .pdfData(let data): return data.canCreateExportFile
        case .pdfFile: return true
        case .string: return true
        }
    }
    
    public func print(_ item: PrintItem) throws {
        switch item {
        case .attributedString(let string, let config): try print(string, withConfiguration: config)
        case .imageData: throw PrinterError.unsupportedOperation
        case .imageFile: throw PrinterError.unsupportedOperation
        case .pdfData(let data): try print(pdfData: data)
        case .pdfFile(let url): try print(pdfFileAt: url)
        case .string(let string, let config): try print(string, withConfiguration: config)
        }
    }
}

private extension StandardPrinter {
    
    func print(
        _ string: String,
        withConfiguration config: Pdf.PageConfiguration
    ) throws {
        try print(
            NSAttributedString(string: string),
            withConfiguration: config
        )
    }
    
    func print(
        _ string: NSAttributedString,
        withConfiguration config: Pdf.PageConfiguration
    ) throws {
        let data = try string.pdfData(withConfiguration: config)
        try print(pdfData: data)
    }
    
    func print(pdfData data: Data) throws {
        let url = try data.createExportFile(withExtension: "pdf")
        try print(pdfFileAt: url)
    }
    
    func print(pdfFileAt url: URL?) throws {
        guard let url else { throw PrinterError.invalidUrl }
        let view = PDFView()
        let window = NSWindow()
        view.document = PDFDocument(url: url)
        window.setContentSize(view.frame.size)
        window.contentView = view
        window.center()
        view.print(with: .shared, autoRotate: true)
    }
}
#endif
