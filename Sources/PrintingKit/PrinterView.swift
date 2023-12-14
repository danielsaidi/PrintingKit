//
//  PrinterView.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any view that should be
 able to print ``PrintItem`` types.
 
 Implementing this protocol gives the view access to a bunch
 of convenient print functions.
 */
public protocol PrinterView: View {}

public extension PrinterView {
    
    /**
     Whether or not the view can print images.
     
     - Parameters:
       - printer: The printer to use.
     */
    func canPrintImages(
        with printer: Printer = .init()
    ) -> Bool {
        printer.canPrintImages
    }
    
    /**
     Whether or not the view can print a certain print item.
     
     - Parameters:
       - item: The item to print.
       - printer: The printer to use.
     */
    func canPrintItem(
        _ item: PrintItem?,
        with printer: Printer = .init()
    ) -> Bool {
        guard let item else { return false }
        return printer.canPrint(item)
    }
    
    /**
     Whether or not the view can print views.
     
     - Parameters:
       - printer: The printer to use.
     */
    func canPrintViews(
        with printer: Printer = .init()
    ) -> Bool {
        printer.canPrintViews
    }
    
    /**
     Print a certain print item.
     
     - Parameters:
       - item: The item to print.
       - printer: The printer to use.
     */
    func printItem(
        _ item: PrintItem,
        with printer: Printer = .init()
    ) throws {
        try printer.print(item)
    }
    
    /**
     Try to print the provided view as an image.
     
     - Parameters:
       - view: The view to print.
       - scale: The scale to print in, by default `2`.
     */
    @MainActor
    @available(iOS 16.0, macOS 13.0, *)
    func printView<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        printer: Printer = .init()
    ) throws {
        let item = try PrintItem.view(view, withScale: scale)
        try printer.print(item)
    }
    
    /**
     Try to print the provided view as an image.
     
     - Parameters:
       - view: The view to print.
       - scale: The scale to print in, by default `2`.
     */
    @available(iOS 16.0, macOS 13.0, *)
    func printViewAsTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        with printer: Printer = .init()
    ) {
        Task {
            try? await printView(
                view,
                withScale: scale,
                printer: printer
            )
        }
    }
}
