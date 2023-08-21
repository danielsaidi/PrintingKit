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
    
    public func canPrint(_ item: PrintItem) -> Bool {
        switch item {
        case .imageData(let data): return data.canCreateExportFile
        case .imageFile: return true
        case .pdfData(let data): return data.canCreateExportFile
        case .pdfFile: return true
        }
    }
    
    public func print(_ item: PrintItem) throws {
        switch item {
        case .imageData(let data): try printItem(at: data.createExportFile(withExtension: "img"))
        case .imageFile(let url): try printItem(at: url)
        case .pdfData(let data): try printItem(at: data.createExportFile(withExtension: "pdf"))
        case .pdfFile(let url): try printItem(at: url)
        }
    }
}

private extension StandardPrinter {
    
    func printItem(at url: URL?) throws {
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
