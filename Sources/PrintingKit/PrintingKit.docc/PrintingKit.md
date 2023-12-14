# ``PrintingKit``

PrintingKit helps you print PDF documents, images, etc. in Swift and SwiftUI.


## Overview

![Library logotype](Logo.png)


## Supported Item Types

PrintingKit currently supports the following printable types:

* ``PrintItem/attributedString(_:configuration:)`` - an attributed string.
* ``PrintItem/imageData(_:)`` - JPG or PNG data (iOS only).
* ``PrintItem/imageFile(at:)`` - a JPG or PNG file at a certain URL (iOS only).
* ``PrintItem/pdfData(_:)`` - PDF document data.
* ``PrintItem/pdfFile(at:)`` - a PDF document file at a certain URL.
* ``PrintItem/string(_:configuration:)`` - a plain string.
* ``PrintItem/view(_:withScale:)`` - any SwiftUI view (iOS only).

Note that some items currently can't be printed on some platforms.



## Installation

PrintingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PrintingKit.git
```

If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Getting started

The <doc:Getting-Started> article helps you get started with ApiKit.



## Repository

For more information, source code, etc., visit the [project repository][Repository].



## License

PrintingKit is available under the MIT license. See the [LICENSE][License] file for more info.



## Topics

### Articles

- <doc:Getting-Started>

### Essentials

- ``Printer``
- ``PrintItem``

### Pdf

- ``Pdf``
- ``PdfDataSource``



[License]: https://github.com/danielsaidi/PrintingKit/blob/master/LICENSE
[Repository]: https://github.com/danielsaidi/PrintingKit
