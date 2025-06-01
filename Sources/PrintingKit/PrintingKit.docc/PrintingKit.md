# ``PrintingKit``

PrintingKit is a Swift SDK that helps you print images, strings, views, PDFs etc. in Swift and SwiftUI.


## Overview

![Library logotype](Logo.png)

PrintingKit is a SwiftUI library that lets you print images, strings, views, files, PDFs, etc. from any SwiftUI app. Just create a ``Printer`` instance or use the ``Printer/shared`` printer, then call any of its print functions to print.



## Installation

PrintingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PrintingKit.git
```


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting started

To print, just create a ``Printer`` instance, or use the ``Printer/shared`` printer, then use it to print any of the following supported printable types:

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

In SwiftUI, you can either print programatically, when a user taps/clicks a button, etc.:

```swift
struct MyView: View {

    var body: some View {
        VStack {
            Button("Print something") {
                do {
                    try? Printer.shared.printString("Hello, world!") 
                } catch {
                    print("Handle this \(error)")
                }
            }
        }
    }
}
``` 

PrintingKit also has PDF utilities, which are used to print certain types. Since these utilies are the only ones that support paper size, page margins, etc. we should aim to make more print functions use PDF as print format.

> Note: Only some functions support providing a custom page configuration, which can be used to specify paper size and margins. More functions should support this functionality in the future.



## macOS Sandbox Configuration

For a sandboxed application (default on macOS), you must allow printing in the target's "Signing & Capabilities" > "App Sandbox" section or, you'll be met with the error "This application does not support printing.".



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



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi
