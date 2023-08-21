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
     Print a printable item.
     
     - Parameters:
       - item: The item to print.
       - printer: The printer to use, by default `.standard`.
     */
    func print(
        _ item: PrintItem,
        with printer: Printer = .standard
    ) {
        printer.print(item)
    }
}
