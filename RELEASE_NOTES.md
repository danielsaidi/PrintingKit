# Release Notes

PrinterKit will use semantic versioning after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.2

This version adds PDF utilities and more print item types. 

### ✨ New Features

* `Pdf` is a new namespace with PDF-specific types.
* `PdfDataSource` is a new protocol that is implemented by `NSAttributedString`.
* `PrintItem` has new `.imageData`, `.pdfData` and `.view` types.
* `PrinterView` has a new `canPrintItem(:with:)` function.

### 🚨 Breaking changes

* `PrinterItem.image(at:)` has been renamed to `.imageFile`.
* `PrinterItem.pdf(at:)` has been renamed to `.pdfFile`.


## 0.1

This is the first beta release. 

### ✨ New Features

* `Printer` is a protocol that defines a printer.
* `PrinterError` is a printer-specific error enum.
* `PrinterView` is a `SwiftUI` protocol that adds printing capabilities to SwiftUI views.
* `PrintItem` is an enum that describes the currently supported item types.
* `StandardPrinter` is a standard printer implementation.
