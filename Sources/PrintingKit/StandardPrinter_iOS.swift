//
//  StandardPrinter.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 This class implements the ``Printer`` protocol for iOS.
 
 This class uses a `UIPrintInteractionController` to perform
 the print operation.
 */
public class StandardPrinter: Printer {
    
    public init() {}
    
    public var canPrintImages: Bool {
        return true
    }
    
    public func canPrint(_ item: PrintItem) -> Bool {
        switch item {
        case .attributedString: return true
        case .imageData(let data): return data.canCreateExportFile
        case .imageFile: return true
        case .pdfData(let data): return data.canCreateExportFile
        case .pdfFile: return true
        }
    }
    
    public func print(_ item: PrintItem) throws {
        switch item {
        case .attributedString(let string, let config): try print(string, withPageConfiguration: config)
        case .imageData(let data): try print(imageData: data)
        case .imageFile(let url): try print(fileAt: url)
        case .pdfData(let data): try print(pdfData: data)
        case .pdfFile(let url): try print(fileAt: url)
        }
    }
}

private extension StandardPrinter {
    
    func print(
        _ data: Data,
        withFileExtension ext: String
    ) throws {
        let url = try data.createExportFile(withExtension: ext)
        try print(fileAt: url)
    }
    
    func print(
        _ string: NSAttributedString,
        withPageConfiguration config: Pdf.PageConfiguration
    ) throws {
        let data = try string.pdfData(withConfiguration: config)
        try print(pdfData: data)
    }
    
    func print(imageData data: Data) throws {
        try print(data, withFileExtension: "img")
    }
    
    func print(pdfData data: Data) throws {
        try print(data, withFileExtension: "pdf")
    }
    
    func print(fileAt url: URL?) throws {
        guard let url else { throw PrinterError.invalidUrl }
        let info = UIPrintInfo(dictionary: nil)
        info.outputType = .general
        info.jobName = "Standard Printer Job"
        let controller = UIPrintInteractionController.shared
        controller.printInfo = info
        controller.printingItem = url
        controller.present(animated: true)
    }
}
#endif
