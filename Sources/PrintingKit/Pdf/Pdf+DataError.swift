//
//  Pdf+DataError.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Pdf {
    
    /// This error type can be thrown when creating PDF data.
    enum DataError: Error {
        
        /// The platform is currently not supported
        case unsupportedPlatform
    }
}
