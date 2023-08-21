//
//  Printer.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that can print
 printable items.
 */
public protocol Printer {
    
    /**
     Whether or not the printer can print the provided item.
     */
    func canPrint(_ item: PrintItem) -> Bool
    
    /**
     Print the provided item.
     */
    func print(_ item: PrintItem) throws
}

public extension Printer where Self == StandardPrinter {
    
    /// Create a standard printer.
    static var standard: Printer {
        Self()
    }
}
