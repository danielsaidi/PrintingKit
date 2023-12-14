# Release Notes

PrinterKit will use semantic versioning after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.3

PrintingKit now builds on all Apple platforms, to let you import it without complicated, conditional adjustments.

This version bumps to Swift 5.9 and replaces `Printer` with `StandardPrinter` to avoid having a protocol. 

### ✨ New Features

* `Printer` is now open to inheritance and customizations.

### 💡 Behavior Changes

* `Printer` is now a single class for all supported platforms.
* `PrintItem.string` is now a proper enum case.

### 🗑️ Deprecations

* `Pdf.PdfDataError` has been renamed to `Pdf.DataError`.
* `PrinterError` has been renamed to `Printer.PrintError`.
* `PrinterView.canPrintItem(...)` has been renamed to `PrintView.canPrint(...)`.
* `PrinterView.printItem(...)` has been renamed to `PrintView.print(...)`.
* `PrinterView.printView(...)` has been renamed to `PrintView.print(...)`.
* `PrinterView.printViewAsTask(...)` has been renamed to `PrintView.printInTask(...)`.


## 0.2

This version adds PDF utilities and more print item types. 

### ✨ New Features

* `Pdf` is a new namespace with PDF-specific types.
* `PdfDataSource` is a new protocol that is implemented by `NSAttributedString`.
* `Printer` has new `canPrint` functions and properties.
* `PrinterView` has new `canPrint` functions.
* `PrintItem` has new `.imageData`, `.pdfData`, `.attributedString`, `.string` and `.view` types.

### 💥 Breaking Changes

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
