# Getting Started

This article explains how to get started with PrintingKit.


## Overview

PrintingKit helps you print PDF documents and other items in Swift and SwiftUI.

For instance, to print a PDF in SwiftUI, just do this:

```swift
struct MyView: View {

    private let pdfUrl = Bundle.main.url(
        forResource: "document", 
        withExtension: "pdf"
    )

    var body: some View {
        Button("Print document") {
            if let pdfUrl {
                StandardPrinter().print(.pdf(at: pdfUrl))
            }
        }
    }
}
```


## Available item types

For now, PrintingKit supports the following item types:

* ``PrintItem/pdf(at:)`` - a PDF at a certain URL.
* ``PrintItem/pdfWithName(_:extension:in:)`` - a named PDF in a certain bundle.

More types may be added in the future.



## SwiftUI extensions

To make printing in SwiftUI even easier, any view can implement the ``PrinterView`` protocol to get access to more functionality.

For instance, you then don't have to provide a printer instance:

```swift
struct MyView: View, PrinterView {

    private let url = Bundle.main.url(
        forResource: "document", 
        withExtension: "pdf"
    )

    var body: some View {
        Button("Print document") {
            if let url {
                print(.pdf(at: url)
            }
        }
    }
}
```

More view-specific functionality may be added in the future.
