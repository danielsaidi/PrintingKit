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
        case .image: return false
        case .pdf: return true
        }
    }
    
    public func print(_ item: PrintItem) throws {
        switch item {
        case .image: throw PrinterError.unsupportedOperation
        case .pdf(let url): try printPdf(at: url)
        }
    }
}

private extension StandardPrinter {
    
    func printPdf(at url: URL?) throws {
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
