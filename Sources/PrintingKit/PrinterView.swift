//
//  PrinterView.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any view that should be
 able to print ``PrintItem`` types.
 */
public protocol PrinterView: View {}

public extension PrinterView {
    
    /**
     Whether or not the view can print a certain print item.
     
     - Parameters:
       - item: The item to print.
       - printer: The printer to use, by default `.standard`.
     */
    func canPrintItem(
        _ item: PrintItem?,
        with printer: Printer = .standard
    ) -> Bool {
        guard let item else { return false }
        return printer.canPrint(item)
    }
    
    /**
     Print a certain print item.
     
     - Parameters:
       - item: The item to print.
       - printer: The printer to use, by default `.standard`.
     */
    func printItem(
        _ item: PrintItem,
        with printer: Printer = .standard
    ) throws {
        try printer.print(item)
    }
}
