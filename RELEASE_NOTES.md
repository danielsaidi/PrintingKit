# Release Notes

PrinterKit will use semantic versioning after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.7.1

Thanks to [vliegeois](https://github.com/vliegeois), PrintingKit now targets macOS 10.15 instead of 11.



## 0.7

This version replaces `PrintItem` with separate `Printer` functions.

### ✨ Features

* `Printer` has separate print functions for each operation.
* `Printer` has new functions for printing views and images.

### 💡 Adjustments

### 🗑️ Deprecations

* `PrintItem` is deprecated.
* `Pdf.PageConfiguration` is moved to `Printer`.
* `Pdf.PageMargins` is moved to `Printer`.



## 0.6

This version makes PrintingKit use Swift 6.



## 0.5.2

This version removes actor information from the PdfDataSource protocol.



## 0.5.1

This version enables support for strict concurrency.



## 0.5

This version removes previously deprecated code.



## 0.4.2

Thanks to [Cihat Gündüz](https://github.com/FlineDevPublic), this version makes PrintingKit work on visionOS.



## 0.4.1

This version makes PrintingKit work on macOS Catalyst.



## 0.4

This version makes view and image printing work on macOS.

### ✨ New Features

* Image and view printing now works on macOS.

### 🗑️ Deprecations

* All previously deprecated code has been removed.

* `Printer.canPrintImages` has been deprecated.
* `Printer.canPrintViews` has been deprecated.



## 0.3

This version bumps to Swift 5.9 and replaces the `Printer` protocol with a class to make the library less complex.

Due to this, the `PrinterView` is no longer needed, and has been deprecated.

Plus, PrintingKit now builds on all Apple platforms, to let you import it without complicated, conditional adjustments.

### 💡 Behavior Changes

* `Printer` is now a single, open class on all supported platforms.
* `PrintItem.string` is now a proper enum case.

### 🗑️ Deprecations

* `Pdf.PdfDataError` has been renamed to `Pdf.DataError`.
* `PrinterError` has been renamed to `Printer.PrintError`.
* `PrinterView` is deprecated. Use `Printer` directly.



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
