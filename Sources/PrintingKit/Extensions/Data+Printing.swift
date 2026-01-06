//
//  Data+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import Foundation

extension Data {
    
    var canCreatePrintFile: Bool {
        FileManager.default.hasCachesDirectory
    }
    
    func canCreatePrintFile(
        withExtension ext: String
    ) throws -> URL {
        try FileManager.default.createCacheFile(
            with: self,
            fileExtension: ext
        )
    }
}
