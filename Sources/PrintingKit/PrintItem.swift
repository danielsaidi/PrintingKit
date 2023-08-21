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
 to make it easier to create item types. A printer can throw
 a ``PrinterError`` if the URL is not set for a certain item.
 */
public enum PrintItem {
    
    /// An JPG or PNG image file at a certain URL.
    case imageFile(at: URL?)
    
    /// JPG or PNG image data.
    case imageData(Data)
    
    /// A PDF document file at a certain URL.
    case pdfFile(at: URL?)
    
    /// PDF document data.
    case pdfData(Data)
}

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

private extension FileManager {
    
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
        else { throw PrinterError.cachesDirectoryDoesNotExist }
        try? removeItem(at: fileUrl)
        createFile(atPath: fileUrl.path, contents: data)
        return fileUrl
    }
}
