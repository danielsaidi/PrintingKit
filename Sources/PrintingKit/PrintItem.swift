//
//  PrintItem.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines all printable types that are supported by
 this library.
 */
public enum PrintItem {
    
    /// A PDF document at a certain URL.
    case pdf(at: URL)
}
