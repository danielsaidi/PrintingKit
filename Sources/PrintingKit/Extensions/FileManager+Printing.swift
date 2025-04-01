//
//  FileManager+Printing.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2025-04-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension FileManager {
    
    var cachesDirectoryUrl: URL? {
        urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    var hasCachesDirectory: Bool {
        cachesDirectoryUrl != nil
    }
    
    func createCacheFile(
        with data: Data,
        fileExtension: String
    ) throws -> URL {
        let id = UUID().uuidString
        guard let fileUrl = cachesDirectoryUrl?
            .appendingPathComponent(id)
            .appendingPathExtension(fileExtension)
        else { throw Printer.PrintError.cachesDirectoryDoesNotExist }
        try? removeItem(at: fileUrl)
        createFile(atPath: fileUrl.path, contents: data)
        return fileUrl
    }
}
