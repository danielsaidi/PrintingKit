//
//  Printer_macOS.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
import PDFKit
#endif

import SwiftUI

#if os(iOS) || os(macOS) || os(visionOS)
/**
 This class can be used to print any supported ``PrintItem``.
 
 You can use the static ``Printer/shared`` if you don't want
 to use separate instances or custom implementations.
 
 You can inherit this class then override any parts you want.
 */
@MainActor
open class Printer {
    
    /// Create a printer instance.
    public init() {}
    
    /// Whether or not the printer can print a certain item.
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
    
    /// Print the provided item.
    open func print(_ item: PrintItem) throws {
        switch item {
        case .attributedString(let str, let conf): try print(str, config: conf)
        case .imageData(let data): try print(imageData: data)
        case .imageFile(let url): try print(imageFileAt: url)
        case .pdfData(let data): try print(pdfData: data)
        case .pdfFile(let url): try print(fileAt: url)
        case .string(let str, let conf): try print(str, config: conf)
        }
    }
    
    /// Print the provided view within a non-thowing task.
    ///
    /// This is useful, since ``PrintItem/view(_:withScale:)``
    /// is async, which is a bit complicated to use in views.
    @available(iOS 16.0, macOS 13.0, *)
    open func printViewInTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2
    ) {
        Task {
            let item = try PrintItem.view(view, withScale: scale)
            try? print(item)
        }
    }
    
    /// A shared printer instance.
    ///
    /// You can replace this to change the global default.
    public static var shared = Printer()
}

@MainActor
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
    
    func print(fileAt url: URL?) throws {
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
    
    func print(imageData data: Data) throws {
        #if os(iOS) || os(visionOS)
        let url = try data.createExportFile(withExtension: "img")
        try print(fileAt: url)
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
    
    func print(imageFileAt url: URL?) throws {
        guard let url else { throw Printer.PrintError.invalidUrl }
        #if os(iOS) || os(visionOS)
        try print(fileAt: url)
        #else
        Task {
            let result = try await URLSession.shared.data(from: url)
            try print(imageData: result.0)
        }
        #endif
    }
    
    func print(pdfData data: Data) throws {
        let url = try data.createExportFile(withExtension: "pdf")
        try print(fileAt: url)
    }
}
#endif
