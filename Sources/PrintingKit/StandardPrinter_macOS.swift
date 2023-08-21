//
//  StandardPrinter.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-04-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
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
        case .pdf: return true
        }
    }
    
    public func printItem(_ item: PrintItem) {
        switch item {
        case .pdf(let url): printPdf(at: url)
        }
    }
}

private extension StandardPrinter {
    
    func printPdf(at url: URL) {
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
