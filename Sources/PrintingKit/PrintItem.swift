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
 
 The URL-based item types use optional URLs as a convenience,
 to make it easier to create item types. All printers in the
 library will throw a ``PrinterError`` if the URL is not set
 for the provided item.
 */
public enum PrintItem {
    
    /// An JPG or PNG image at a certain URL.
    case image(at: URL?)
    
    /// A PDF document at a certain URL.
    case pdf(at: URL?)
}

public extension PrintItem {
    
    /// The item's source URL, if any.
    var sourceUrl: URL? {
        switch self {
        case .image(let url): return url
        case .pdf(let url): return url
        }
    }
}
