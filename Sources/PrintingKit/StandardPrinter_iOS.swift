//
//  StandardPrinter.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-04-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
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
        case .pdf: return true
        }
    }
    
    public func printItem(_ item: PrintItem) {
        switch item {
        case .pdf: printPdf(item)
        }
    }
}

private extension StandardPrinter {
    
    func printPdf(_ item: PrintItem) {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "Standard Print Job"
        let controller = UIPrintInteractionController.shared
        controller.printInfo = printInfo
        controller.printingItem = item
        controller.present(animated: true)
    }
}
#endif
