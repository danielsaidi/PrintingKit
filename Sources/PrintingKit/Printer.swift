//
//  Printer_macOS.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
import PDFKit
#endif

import SwiftUI

#if os(iOS) || os(macOS) || os(visionOS)
/// This class can be used to print any ``PrintItem``.
///
/// You can use ``Printer/shared`` if you do not want to use
/// separate instances or custom implementations.
@MainActor
open class Printer {
    
    /// Create a printer instance.
    public init() {}
    
    
    /// A shared printer instance.
    ///
    /// You can replace this to change the global default.
    public static var shared = Printer()
    
    
    /// Print the provided attributed string.
    open func printAttributedString(
        _ string: NSAttributedString,
        config: Pdf.PageConfiguration
    ) throws {
        let data = try string.pdfData(withConfiguration: config)
        try printPdfData(data)
    }
    
    /// Print the provided data for a certain file extension.
    open func printData(
        _ data: Data,
        withFileExtension ext: String
    ) throws {
        let url = try data.createExportFile(withExtension: ext)
        try printFile(at: url)
    }
    
    /// Print a file at the provided URL.
    open func printFile(at url: URL?) throws {
        guard let url else { throw Printer.PrintError.invalidUrl }
        DispatchQueue.main.async {
            #if os(iOS) || os(visionOS)
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
    
    /// Print the provided image data.
    open func printImageData(_ data: Data) throws {
        #if os(iOS) || os(visionOS)
        let url = try data.createExportFile(withExtension: "img")
        try printFile(at: url)
        #else
        guard let image = NSImage(data: data) else { return }
        let imageView = NSImageView(image: image)
        imageView.frame = NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageView.imageScaling = .scaleProportionallyDown
        let printOperation = NSPrintOperation(view: imageView)
        let printInfo = NSPrintInfo.shared
        printInfo.horizontalPagination = .fit
        printInfo.verticalPagination = .fit
        printOperation.printInfo = printInfo
        printOperation.showsPrintPanel = true
        printOperation.showsProgressPanel = true
        printOperation.run()
        #endif
    }
    
    /// Print an image file at the provided URL.
    open func printImageFile(at url: URL?) throws {
        guard let url else { throw Printer.PrintError.invalidUrl }
        #if os(iOS) || os(visionOS)
        try printFile(at: url)
        #else
        Task {
            let result = try await URLSession.shared.data(from: url)
            try printImageData(result.0)
        }
        #endif
    }
    
    /// Print the provided PDF formatted data.
    open func printPdfData(_ data: Data) throws {
        let url = try data.createExportFile(withExtension: "pdf")
        try printFile(at: url)
    }
    
    /// Print the provided string.
    open func printString(
        _ string: String,
        config: Pdf.PageConfiguration
    ) throws {
        let string = NSAttributedString(string: string)
        try printAttributedString(string, config: config)
    }
    
    /// Print the provided view as an image.
    @available(iOS 16.0, macOS 13.0, *)
    open func printView<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2
    ) throws {
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        guard let data = renderer.imageData else { throw Printer.PrintError.invalidViewData }
        try? printImageData(data)
    }
    
    
    
    /// MARK: - Deprecated
    
    @available(iOS 16.0, macOS 13.0, *)
    @available(*, deprecated, message: "Use `printView(_:withScale:)` instead.")
    open func printViewInTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2
    ) {
        Task {
            let renderer = ImageRenderer(content: view)
            renderer.scale = scale
            guard let data = renderer.imageData else { throw Printer.PrintError.invalidViewData }
            try? printImageData(data)
        }
    }
    
    @available(*, deprecated, message: "The PrintItem concept is deprecated. Use the separate print functions instead.")
    open func canPrint(_ item: PrintItem) -> Bool {
        switch item {
        case .attributedString: true
        case .imageData(let data): data.canCreateExportFile
        case .imageFile: true
        case .pdfData(let data): data.canCreateExportFile
        case .pdfFile: true
        case .string: true
        }
    }
    
    @available(*, deprecated, message: "The PrintItem concept is deprecated. Use the separate print functions instead.")
    open func print(_ item: PrintItem) throws {
        switch item {
        case .attributedString(let str, let conf): try printAttributedString(str, config: conf)
        case .imageData(let data): try printImageData(data)
        case .imageFile(let url): try printImageFile(at: url)
        case .pdfData(let data): try printPdfData(data)
        case .pdfFile(let url): try printFile(at: url)
        case .string(let str, let conf): try printString(str, config: conf)
        }
    }
}
#endif
