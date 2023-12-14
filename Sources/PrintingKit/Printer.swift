//
//  Printer_macOS.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
import PDFKit
#endif

#if os(iOS) || os(macOS)
/**
 This class implements the ``Printer`` protocol for macOS.
 
 This class uses a `AppKit` and `PDFKit` to perform printing.
 */
open class Printer {
    
    public init() {}
    
    /// Whether or not the printer can print a certain item.
    open func canPrint(_ item: PrintItem) -> Bool {
        switch item {
        case .attributedString: return true
        case .imageData(let data): 
            #if os(iOS)
            return data.canCreateExportFile
            #elseif os(macOS)
            return canPrintImages
            #endif
        case .imageFile:
            #if os(iOS)
            return true
            #elseif os(macOS)
            return canPrintImages
            #endif
        case .pdfData(let data): return data.canCreateExportFile
        case .pdfFile: return true
        case .string: return true
        }
    }
    
    /// Print the provided item.
    open func print(_ item: PrintItem) throws {
        switch item {
        case .attributedString(let str, let conf): try print(str, config: conf)
        case .imageData(let data): try print(imageData: data)
        case .imageFile(let url): try print(fileAt: url)
        case .pdfData(let data): try print(pdfData: data)
        case .pdfFile(let url): try print(fileAt: url)
        case .string(let str, let conf): try print(str, config: conf)
        }
    }
}

public extension Printer {
    
    /// Whether or not the printer can print images.
    var canPrintImages: Bool {
        #if os(iOS)
        return true
        #else
        return false
        #endif
    }
    
    /// Whether or not the printer can print views.
    var canPrintViews: Bool {
        canPrintImages
    }
}

private extension Printer {
    
    func print(
        _ data: Data,
        withFileExtension ext: String
    ) throws {
        let url = try data.createExportFile(withExtension: ext)
        try print(fileAt: url)
    }
    
    func print(
        _ string: String,
        config: Pdf.PageConfiguration
    ) throws {
        let string = NSAttributedString(string: string)
        try print(string, config: config)
    }
    
    func print(
        _ string: NSAttributedString,
        config: Pdf.PageConfiguration
    ) throws {
        let data = try string.pdfData(withConfiguration: config)
        try print(pdfData: data)
    }
    
    func print(imageData data: Data) throws {
        try print(data, withFileExtension: "img")
    }
    
    func print(pdfData data: Data) throws {
        let url = try data.createExportFile(withExtension: "pdf")
        try print(fileAt: url)
    }
    
    func print(fileAt url: URL?) throws {
        guard let url else { throw Printer.PrintError.invalidUrl }
        #if os(iOS)
        let info = UIPrintInfo(dictionary: nil)
        info.outputType = .general
        info.jobName = "Standard Printer Job"
        let controller = UIPrintInteractionController.shared
        controller.printInfo = info
        controller.printingItem = url
        controller.present(animated: true)
        #elseif os(macOS)
        let view = PDFView()
        let window = NSWindow()
        view.document = PDFDocument(url: url)
        window.setContentSize(view.frame.size)
        window.contentView = view
        window.center()
        view.print(with: .shared, autoRotate: true)
        #endif
    }
}
#endif
