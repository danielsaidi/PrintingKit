//
//  PrinterError.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This error can be thrown by ``Printer`` operations.
 */
public enum PrinterError: Error {
    
    /// The operation could not generate a cache file.
    case cachesDirectoryDoesNotExist
    
    /// The print item is configured with an invalid URL.
    case invalidUrl
    
    /// The operation is not supported by the platform.
    case unsupportedOperation
}
