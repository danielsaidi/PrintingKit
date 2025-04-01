<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/PrintingKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" title="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/PrintingKit" alt="MIT License" title="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>


# PrintingKit

PrintingKit is a Swift and SwiftUI SDK that helps you print images, strings, views, PDFs etc. directly from your app.

With PrintingKit, you just have to create a `Printer` instance, or use `Printer.shared`, then use it to print any of the following supported printable types:

* `printAttributedString(_:config:)` - print an attributed string.
* `printData(_:withFileExtension:)` - try to print generic data.
* `printFile(at:)` - try to print a generic file.
* `printImage(_:)` - print a `UIImage` or `NSImage`.
* `printImageData(_:)` - print JPG or PNG data.
* `printImageFile(at:)` - print a JPG or PNG file at a certain URL.
* `printPdfData(_:)` - print PDF document data.
* `printPdfFile(at:)` - print a PDF document file at a certain URL.
* `printString(_:config:)` - print a plain string.
* `printView(_:withScale:)` - print a SwiftUI view.

Note that only certain functions support providing a page configuration, which can specify paper size and margins.

PrintingKit works on both iOS and macOS.



## Installation

PrintingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PrintingKit.git
```



## Getting started

To print any of supported print item type, just create a `Printer` instance, or use `Printer.shared`:

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



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you explore the library.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



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
