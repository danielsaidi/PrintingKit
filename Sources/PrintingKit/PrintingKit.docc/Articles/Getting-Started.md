# Getting Started

This article explains how to get started with PrintingKit.


## Overview

PrintingKit helps you print printable items in Swift and SwiftUI.

For instance, to print a PDF file in SwiftUI, just do this:

```swift
struct MyView: View {

    private let url = Bundle.main.url(
        forResource: "document", 
        withExtension: "pdf"
    )

    var body: some View {
        Button("Print document") {
            if let url {
                StandardPrinter().print(.pdf(at: url)
            }
        }
    }
}
```


## View utilities

To make printing from SwiftUI views even easier, any view can implement the `PrinterView` protocol, to get access to more functionality:

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
