//
//  PrinterTests.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import PrintingKit
import XCTest

final class PrinterTests: XCTestCase {
    
    let printer = Printer()
    
    func testCanPrintImagesOnlyOniOS() throws {
        let canPrint = printer.canPrintImages
        #if os(iOS)
        XCTAssertTrue(canPrint)
        #else
        XCTAssertFalse(canPrint)
        #endif
    }
    
    func testCanPrintViewsOnlyOniOS() throws {
        let canPrint = printer.canPrintViews
        #if os(iOS)
        XCTAssertTrue(canPrint)
        #else
        XCTAssertFalse(canPrint)
        #endif
    }
}
