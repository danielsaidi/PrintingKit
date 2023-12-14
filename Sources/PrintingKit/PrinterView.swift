//
//  PrinterView.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

/**
 This protocol can be implemented by any view that should be
 able to print ``PrintItem`` types.
 
 Implementing the protocol gives a view access to convenient
 print functions, where a printer only has to be provided if
 the view wants to use a custom printer.
 */
public protocol PrinterView: View {}

public extension PrinterView {
    
    /// Whether or not the view can print images.
    func canPrintImages(
        with printer: Printer = .init()
    ) -> Bool {
        printer.canPrintImages
    }
    
    /// Whether or not the view can print a certain item.
    func canPrint(
        _ item: PrintItem?,
        with printer: Printer = .init()
    ) -> Bool {
        guard let item else { return false }
        return printer.canPrint(item)
    }
    
    /// Whether or not the view can print views.
    func canPrintViews(
        with printer: Printer = .init()
    ) -> Bool {
        printer.canPrintViews
    }
    
    /// Print the provided item.
    func print(
        _ item: PrintItem,
        with printer: Printer = .init()
    ) throws {
        try printer.print(item)
    }
    
    /// Print the provided view.
    @MainActor
    @available(iOS 16.0, macOS 13.0, *)
    func print<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        printer: Printer = .init()
    ) throws {
        let item = try PrintItem.view(view, withScale: scale)
        try printer.print(item)
    }
    
    /// Print the provided view as a non-thowing task.
    ///
    /// This function can be used when you're not interested
    /// in any errors being thrown.
    @available(iOS 16.0, macOS 13.0, *)
    func printInTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        printer: Printer = .init()
    ) {
        Task {
            try? await print(
                view,
                withScale: scale,
                printer: printer
            )
        }
    }
    
    
    @available(*, deprecated, renamed: "canPrint(_:with:)")
    func canPrintItem(
        _ item: PrintItem?,
        with printer: Printer = .init()
    ) -> Bool {
        canPrint(item, with: printer)
    }
    
    @available(*, deprecated, renamed: "print(_:with:)")
    func printItem(
        _ item: PrintItem,
        with printer: Printer = .init()
    ) throws {
        try print(item, with: printer)
    }
    
    @MainActor
    @available(iOS 16.0, macOS 13.0, *)
    @available(*, deprecated, renamed: "print(_:withScale:printer:)")
    func printView<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        printer: Printer = .init()
    ) throws {
        try print(view, withScale: scale, printer: printer)
    }
    
    /// Print the provided view as a non-thowing task.
    ///
    /// This function can be used when you're not interested
    /// in any errors being thrown.
    @available(iOS 16.0, macOS 13.0, *)
    @available(*, deprecated, renamed: "printInTask(_:withScale:printer:)")
    func printViewAsTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        with printer: Printer = .init()
    ) {
        printInTask(view, withScale: scale, printer: printer)
    }
}
#endif
