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

/// This class can be used to print data, strings, files, images, etc.
///
/// Use ``Printer/shared`` if you don't want to use separate instances or a
/// custom implementation.
///
/// > Note: Some print functions support page configurations. This can be used to
/// specify paper size and page margins. This should be added to more functions.
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
        config: PageConfiguration
    ) throws {
        let data = try string.pdfData(withConfiguration: config)
        try printPdfData(data)
    }
    
    /// Print the provided data for a certain file extension.
    open func printData(
        _ data: Data,
        withFileExtension ext: String
    ) throws {
        let url = try data.canCreatePrintFile(withExtension: ext)
        try printFile(at: url)
    }
    
    /// Print a file at the provided URL.
    open func printFile(at url: URL?) throws {
        guard let url else { throw PrintError.invalidUrl }
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
    
    /// Print the provided image's standard print data.
    open func printImage(_ image: PrintableImage) throws {
        guard let data = image.standardPrintData else {
            throw PrintError.failedToExtractPrintDataFromImage
        }
        try printImageData(data)
    }
    
    /// Print the provided image data.
    open func printImageData(_ data: Data) throws {
        #if os(iOS) || os(visionOS)
        let url = try data.canCreatePrintFile(withExtension: "img")
        try printFile(at: url)
        #elseif os(macOS)
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
        #else
        throw PrintError.unsupportedPlatform
        #endif
    }
    
    /// Print an image file at the provided URL.
    open func printImageFile(at url: URL?) throws {
        guard let url else { throw PrintError.invalidUrl }
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
        let url = try data.canCreatePrintFile(withExtension: "pdf")
        try printFile(at: url)
    }
    
    /// Print a PDF file at the provided URL.
    open func printPdfFile(at url: URL) throws {
        try printFile(at: url)
    }
    
    /// Print the provided string.
    open func printString(
        _ string: String,
        config: PageConfiguration
    ) throws {
        let string = NSAttributedString(string: string)
        try printAttributedString(string, config: config)
    }
    
    /// Print the provided view as an image.
    @available(iOS 16.0, macOS 13.0, *)
    open func printView<Content: View>(
        _ view: Content,
        withScale scale: CGFloat = 2
    ) throws {
        #if os(iOS) || os(visionOS) || os(macOS)
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        guard let data = renderer.imageData else { throw PrintError.invalidViewData }
        try? printImageData(data)
        #else
        throw PrintError.unsupportedPlatform
        #endif
    }
}
