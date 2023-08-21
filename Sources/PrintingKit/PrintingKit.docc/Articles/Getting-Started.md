# Getting Started

This article explains how to get started with PrintingKit.


## Overview

PrintingKit helps you print PDF documents and other items in Swift and SwiftUI.

For instance, to print a PDF in SwiftUI, just do this:

```swift
struct MyView: View {

    var body: some View {
        Button("Print document") {
            let bundle = Bundle.main
            let url = bundle.url(forResource: "doc", withExtension: "pdf")
            let item = PrintItem.pdf(at: url)
            try? StandardPrinter().print(item)
        }
    }
}
```

You can also make views implement ``PrinterView`` to make printing even easier.

For instance, you then don't have to specify a ``Printer``:

```swift
struct MyView: View, PrinterView {

    var body: some View {
        Button("Print document") {
            let bundle = Bundle.main
            let url = bundle.url(forResource: "doc", withExtension: "pdf")
            let item = PrintItem.pdf(at: url)
            try? printItem(item)
        }
    }
}
```

More view-specific functionality may be added in the future.


## Available item types

For now, PrintingKit supports the following print item types:

* ``PrintItem/.image(at:)`` - a JPG or PNG file at a certain URL.
* ``PrintItem/.pdf(at:)`` - a PDF document at a certain URL.

Note that some items currently can't be printed on some platforms.

More types may be added in the future.
