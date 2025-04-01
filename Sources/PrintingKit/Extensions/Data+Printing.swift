//
//  Data+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension Data {
    
    var canCreateExportFile: Bool {
        fileManager.hasCachesDirectory
    }
    
    var fileManager: FileManager {
        .default
    }
    
    func createExportFile(
        withExtension ext: String
    ) throws -> URL {
        try fileManager.createCacheFile(
            with: self,
            fileExtension: ext
        )
    }
}
