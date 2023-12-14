//
//  PrinterTests.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import PrintingKit
import SwiftUI
import XCTest

#if os(iOS) || os(macOS)
final class PrinterTests: XCTestCase {
    
    let printer = Printer()
    
    func testCanPrintViewsIdThusImages() async throws {
        let view = Text("Hello")
        let item = try await PrintItem.view(view)
        let canPrint = printer.canPrint(item)
        XCTAssertTrue(canPrint)
    }
}
#endif
