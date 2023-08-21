//
//  PrintItem.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines all printable types that are supported by
 this library.
 
 The URL-based item types use optional URLs as a convenience,
 to make it easier to create item types. A printer can throw
 a ``PrinterError`` if the URL is not set for a certain item.
 */
public enum PrintItem {
    
    /// An attributed string with a PDF page configuration.
    case attributedString(NSAttributedString, configuration: Pdf.PageConfiguration = .standard)
    
    /// JPG or PNG image data.
    case imageData(Data)
    
    /// An JPG or PNG image file at a certain URL.
    case imageFile(at: URL?)
    
    /// PDF document data.
    case pdfData(Data)
    
    /// A PDF document file at a certain URL.
    case pdfFile(at: URL?)
}

@available(iOS 16.0, macOS 13.0, *)
public extension PrintItem {
    
    /**
     Build an ``PrintItem/attributedString(_:configuration:)``
     print item with a plain string.
     
     - Parameters:
       - string: The string to print.
       - configuration: The page configuration to use, by default `.standard`.
     */
    static func string(
        _ string: String,
        configuration: Pdf.PageConfiguration = .standard
    ) -> PrintItem {
        let str = NSAttributedString(string: string)
        return .attributedString(str, configuration: configuration)
    }
    
    /**
     Try to create an ``PrintItem/imageData(_:)`` print item
     by rendering the provided view to an image.
     
     - Parameters:
       - view: The view to print.
       - scale: The scale to print in, by default `2`.
     */
    @MainActor
    static func view<Content: View>(
        _ view: Content,
        withScale scale: CGFloat = 2
    ) throws -> PrintItem {
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        guard let data = renderer.imageData else { throw PrinterError.invalidViewData }
        return imageData(data)
    }
}

@MainActor
@available(iOS 16.0, macOS 13.0, *)
extension ImageRenderer {
    
    var imageData: Data? {
        #if os(iOS)
        uiImage?.pngData()
        #elseif os(macOS)
        nsImage?.jpegData(compressionQuality: 1)
        #else
        nil
        #endif
    }
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

#if canImport(AppKit)
import AppKit

private extension NSImage {
    
    var cgImage: CGImage? {
        cgImage(forProposedRect: nil, context: nil, hints: nil)
    }

    func jpegData(compressionQuality: CGFloat) -> Data? {
        guard let image = cgImage else { return nil }
        let bitmap = NSBitmapImageRep(cgImage: image)
        return bitmap.representation(using: .jpeg, properties: [.compressionFactor: compressionQuality])
    }
}
#endif
