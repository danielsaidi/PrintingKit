//
//  StandardPrinter.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

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
        case .pdf: return true
        case .pdfWithName: return item.url != nil
        }
    }
    
    public func print(_ item: PrintItem) {
        switch item {
        case .pdf(let url):
            printPdf(at: url)
        case .pdfWithName:
            guard let url = item.url else { return }
            printPdf(at: url)
        }
    }
}

private extension StandardPrinter {
    
    func printPdf(at url: URL) {
        #if os(iOS)
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "Standard Printer Job"
        let controller = UIPrintInteractionController.shared
        controller.printInfo = printInfo
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
        #else
        print("Unsupported platform")
        #endif
    }
}
