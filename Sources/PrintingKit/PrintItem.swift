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
    
    /// A PDF document in a certain bundle.
    case pdfWithName(String,
        extension: String,
        in: Bundle
    )
}

extension PrintItem {
    
    /// An optional URL that is used by some items.
    var url: URL? {
        switch self {
        case .pdf(let url):
            return url
        case .pdfWithName(let name, let ext, let bundle):
            return bundle.url(forResource: name, withExtension: ext)
        }
    }
}
