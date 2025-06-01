<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/PrintingKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" title="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <a href="https://danielsaidi.github.io/PrintingKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/PrintingKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/PrintingKit" alt="MIT License" /></a>
    <a href="https://github.com/sponsors/danielsaidi"><img src="https://img.shields.io/badge/sponsor-GitHub-red.svg" alt="Sponsor my work" /></a>
</p>


# PrintingKit

PrintingKit is a SwiftUI library that lets you print images, strings, views, files, PDFs, etc. from any SwiftUI app. Just create a ``Printer`` instance or use the ``Printer.shared`` printer, then call any of its print functions to print.



## Installation

PrintingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PrintingKit.git
```


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting started

To print, just create a ``Printer`` instance, or use the ``Printer.shared`` printer, then use it to print any of the following supported printable types:

* ``printAttributedString(_:config:)`` - print an attributed string.
* ``printData(_:withFileExtension:)`` - try to print generic data.
* ``printFile(at:)`` - try to print a generic file.
* ``printImage(_:)`` - print a `UIImage` or `NSImage`.
* ``printImageData(_:)`` - print JPG or PNG data.
* ``printImageFile(at:)`` - print a JPG or PNG file at a certain URL.
* ``printPdfData(_:)`` - print PDF document data.
* ``printPdfFile(at:)`` - print a PDF document file at a certain URL.
* ``printString(_:config:)`` - print a plain string.
* ``printView(_:withScale:)`` - print a SwiftUI view.

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



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you explore the library.



## Contact

Feel free to reach out if you have questions, or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

PrintingKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/PrintingKit
[License]: https://github.com/danielsaidi/PrintingKit/blob/master/LICENSE
