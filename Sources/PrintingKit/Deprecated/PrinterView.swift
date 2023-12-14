//
//  PrinterView.swift
//  PrintingKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

@available(*, deprecated, message: "Use Printer directly.")
public protocol PrinterView: View {}

@available(*, deprecated, message: "Use Printer directly.")
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
    func printItem(
        _ item: PrintItem,
        with printer: Printer = .init()
    ) throws {
        try printer.print(item)
    }
    
    /// Print the provided view.
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
    
    /// Print the provided view as a non-thowing task.
    ///
    /// This function can be used when you're not interested
    /// in any errors being thrown.
    @available(iOS 16.0, macOS 13.0, *)
    func printViewInTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        printer: Printer = .init()
    ) {
        printer.printViewInTask(view, withScale: scale)
    }
    
    
    @available(*, deprecated, renamed: "canPrint(_:with:)")
    func canPrintItem(
        _ item: PrintItem?,
        with printer: Printer = .init()
    ) -> Bool {
        canPrint(item, with: printer)
    }
    
    /// Print the provided view as a non-thowing task.
    ///
    /// This function can be used when you're not interested
    /// in any errors being thrown.
    @available(iOS 16.0, macOS 13.0, *)
    @available(*, deprecated, renamed: "printViewInTask(_:withScale:printer:)")
    func printViewAsTask<Content: View> (
        _ view: Content,
        withScale scale: CGFloat = 2,
        with printer: Printer = .init()
    ) {
        printViewInTask(view, withScale: scale, printer: printer)
    }
}
#endif
