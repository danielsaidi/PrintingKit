//
//  PrinterError.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import Foundation

public extension Printer {
    
    /**
     This error can be thrown by ``Printer`` operations.
     */
    enum PrintError: Error {
        
        /// The operation could not generate a cache file.
        case cachesDirectoryDoesNotExist
        
        /// The print item is configured with an invalid URL.
        case invalidUrl
        
        /// The print item is configured with an invalid view.
        case invalidViewData
    }
}
#endif
