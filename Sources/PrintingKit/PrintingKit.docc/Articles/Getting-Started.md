# Getting Started

This article explains how to get started with PrintingKit.


## Overview

PrintingKit currently supports the following ``PrintItem`` types:

* ``PrintItem/attributedString(_:configuration:)`` - an attributed string.
* ``PrintItem/imageData(_:)`` - JPG or PNG data (iOS only).
* ``PrintItem/imageFile(at:)`` - a JPG or PNG file at a certain URL (iOS only).
* ``PrintItem/pdfData(_:)`` - PDF document data.
* ``PrintItem/pdfFile(at:)`` - a PDF document file at a certain URL.
* ``PrintItem/string(_:configuration:)`` - a plain string.
* ``PrintItem/view(_:withScale:)`` - any SwiftUI view (iOS only).

To print any of the supported items, just use a `Printer` instance:

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

There's a static ``Printer/shared`` printer instance that you can use if you don't want to create separate printer instances. You can override it to change the global default, for instance when you create a custom ``Printer`` subclass and want to use it everywhere. 
