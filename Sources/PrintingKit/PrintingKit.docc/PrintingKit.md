# ``PrintingKit``

PrintingKit is a Swift SDK that helps you print images, strings, views, PDFs etc. in Swift and SwiftUI.


## Overview

![Library logotype](Logo.png)

PrintingKit is a Swift and SwiftUI SDK that helps you print images, strings, views, PDFs etc. directly from your app.

With PrintingKit, you just have to create a `Printer` instance, or use `Printer.shared`, then use it to print any of the following supported printable types:

* ``Printer/printAttributedString(_:config:)`` - print an attributed string.
* ``Printer/printData(_:withFileExtension:)`` - try to print generic data.
* ``Printer/printFile(at:)`` - try to print a generic file.
* ``Printer/printImage(_:)`` - print a `UIImage` or `NSImage`.
* ``Printer/printImageData(_:)`` - print JPG or PNG data.
* ``Printer/printImageFile(at:)`` - print a JPG or PNG file at a certain URL.
* ``Printer/printPdfData(_:)`` - print PDF document data.
* ``Printer/printPdfFile(at:)`` - print a PDF document file at a certain URL.
* ``Printer/printString(_:config:)`` - print a plain string.
* ``Printer/printView(_:withScale:)`` - print a SwiftUI view.

Note that only certain functions support providing a page configuration, which can specify paper size and margins.

PrintingKit works on both iOS and macOS.



## Installation

PrintingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PrintingKit.git
```



## Getting started

To print any of supported print item type, just create a ``Printer`` instance, or use the ``Printer/shared`` printer:

```swift
struct MyView: View {

    let printer = Printer.shared

    var body: some View {
        VStack {
            Button("Print something") {
                try? printer.print... // Use any of the available print functions
            }
        }
    }
}
``` 

PrintingKit also has PDF utilities, which are used to print certain types. Since these utilies are the only ones that support paper size, page margins, etc. we should aim to make more print functions use PDF as print format.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/PrintingKit).



## License

PrintingKit is available under the MIT license.



## Topics

### Essentials

- ``Printer``
- ``PrintError``
- ``PrintableImage``

### Pdf

- ``Pdf``
- ``PdfDataSource``
