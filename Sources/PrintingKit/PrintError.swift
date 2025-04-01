//
//  PrinterError.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This error can be thrown by ``Printer`` operations.
public enum PrintError: Error {
    
    /// The print operation could not generate a cache file.
    case cachesDirectoryDoesNotExist
    
    /// The print opetation failed to extract print data.
    case failedToExtractPrintDataFromImage
    
    /// The print operation was given an invalid URL.
    case invalidUrl
    
    /// The print operation was given an invalid view.
    case invalidViewData
    
    /// The print operation does not support the current platform.
    case unsupportedPlatform
}
