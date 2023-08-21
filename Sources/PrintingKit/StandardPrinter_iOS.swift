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
    
    /**
     Create a standard printer instance.
     
     - Parameters:
       - jobName: The printer job name, by default "Standard Print Job".
     */
    public init(
        jobName: String = "Standard Print Job"
    ) {
        self.jobName = jobName
    }
    
    private let jobName: String
    
    public func canPrint(_ item: PrintItem) -> Bool {
        switch item {
        case .pdf: return true
        }
    }
    
    public func print(_ item: PrintItem) {
        switch item {
        case .pdf(let url): printPdf(at: url)
        }
    }
}

private extension StandardPrinter {
    
    func printPdf(at url: URL) {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = jobName
        let controller = UIPrintInteractionController.shared
        controller.printInfo = printInfo
        controller.printingItem = url
        controller.present(animated: true)
    }
}
#endif
