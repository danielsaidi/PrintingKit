# Getting Started

This article explains how to get started with PrintingKit.


## Overview

To print any of the supported items, just create a `Printer` instance and do this:

```swift
struct MyView: View {

    let printer = Printer() 

    var body: some View {
        VStack {
            Button("Print PDF") {
                try? printer.print(.pdf(at: anyUrl))
            }
            Button("Print view") {
                try? printer.print(image)
            }
            Button("Print view without try") {
                printer.printInTask(image)
            }
        }
    }
}
```



## Available item types

PrintingKit currently supports the following print item types:

* ``PrintItem/attributedString(_:configuration:)`` - an attributed string.
* ``PrintItem/imageData(_:)`` - JPG or PNG data (iOS only).
* ``PrintItem/imageFile(at:)`` - a JPG or PNG file at a certain URL (iOS only).
* ``PrintItem/pdfData(_:)`` - PDF document data.
* ``PrintItem/pdfFile(at:)`` - a PDF document file at a certain URL.
* ``PrintItem/string(_:configuration:)`` - a plain string.
* ``PrintItem/view(_:withScale:)`` - any SwiftUI view (iOS only).

Note that some items currently can't be printed on some platforms.



## How to check printer capabilities

``Printer`` provides information about which items it can print.

For instance, you can use `canPrint(_:)` to see if it can print a certain item, as well as `canPrintImages` and  `canPrintViews` to see if it can print images and views.
