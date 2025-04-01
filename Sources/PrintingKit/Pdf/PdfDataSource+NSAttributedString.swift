//
//  PdfDataSource+NSAttributedString.swift
//  RichTextKit
//
//  Created by Daniel Saidi on 2022-06-03.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension NSAttributedString: @preconcurrency PdfDataSource {}

@MainActor
public extension NSAttributedString {

    func pdfData() throws -> Data {
        try pdfData(withConfiguration: .standard)
    }

    func pdfData(
        withConfiguration config: Printer.PageConfiguration
    ) throws -> Data {
        #if os(iOS) || os(visionOS)
        try iosPdfData(for: config)
        #elseif os(macOS)
        try macosPdfData(for: config)
        #else
        throw Pdf.DataError.unsupportedPlatform
        #endif
    }
}

#if os(macOS)
import AppKit

@MainActor
private extension NSAttributedString {

    func macosPdfData(for config: Printer.PageConfiguration) throws -> Data {
        do {
            let fileUrl = try macosPdfFileUrl()
            let info = try macosPdfPrintInfo(for: config, fileUrl: fileUrl)
            let scrollView = NSTextView.scrollableTextView()
            scrollView.frame = config.paperRect
            let textView = scrollView.documentView as? NSTextView ?? NSTextView()
            sleepToPrepareTextView()
            textView.textStorage?.setAttributedString(self)

            let operation = NSPrintOperation(view: textView, printInfo: info)
            operation.showsPrintPanel = false
            operation.showsProgressPanel = false
            operation.run()

            return try Data(contentsOf: fileUrl)
        } catch {
            throw(error)
        }
    }

    func macosPdfFileUrl() throws -> URL {
        let manager = FileManager.default
        let cacheUrl = try manager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return cacheUrl
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("pdf")
    }

    func macosPdfPrintInfo(
        for config: Printer.PageConfiguration,
        fileUrl: URL) throws -> NSPrintInfo {
        let options: [NSPrintInfo.AttributeKey: Any] = [
            .jobDisposition: NSPrintInfo.JobDisposition.save,
            .jobSavingURL: fileUrl]
        let info = NSPrintInfo(dictionary: options)
        info.horizontalPagination = .fit
        info.verticalPagination = .automatic
        info.topMargin = config.pageMargins.top
        info.leftMargin = config.pageMargins.left
        info.rightMargin = config.pageMargins.right
        info.bottomMargin = config.pageMargins.bottom
        info.isHorizontallyCentered = false
        info.isVerticallyCentered = false
        return info
    }

    func sleepToPrepareTextView() {
        Thread.sleep(forTimeInterval: 0.1)
    }
}
#endif

#if os(iOS) || os(visionOS)
import UIKit

@MainActor
private extension NSAttributedString {

    func iosPdfData(for config: Printer.PageConfiguration) throws -> Data {
        let renderer = iosPdfPageRenderer(for: config)
        let paperRect = config.paperRect
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, paperRect, nil)
        let range = NSRange(location: 0, length: renderer.numberOfPages)
        renderer.prepare(forDrawingPages: range)
        let bounds = UIGraphicsGetPDFContextBounds()
        for i in 0  ..< renderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            renderer.drawPage(at: i, in: bounds)
        }
        UIGraphicsEndPDFContext()
        return pdfData as Data
    }

    func iosPdfPageRenderer(for configuration: Printer.PageConfiguration) -> UIPrintPageRenderer {
        let formatter = UISimpleTextPrintFormatter(attributedText: self)
        let paperRect = NSValue(cgRect: configuration.paperRect)
        let printableRect = NSValue(cgRect: configuration.printableRect)
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        renderer.setValue(paperRect, forKey: "paperRect")
        renderer.setValue(printableRect, forKey: "printableRect")
        return renderer
    }
}
#endif
