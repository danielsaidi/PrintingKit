#if os(iOS) || os(macOS) || os(visionOS)
import SwiftUI

public extension Pdf {
    
    @available(*, deprecated, renamed: "Printer.PageConfiguration")
    typealias PageConfiguration = Printer.PageConfiguration
    
    @available(*, deprecated, renamed: "Printer.PageMargins")
    typealias PageMargins = Printer.PageMargins
}



@available(*, deprecated, message: "The PrintItem concept is deprecated. Use the Printer class directly.")
public enum PrintItem {
    
    /// An attributed string with a PDF page configuration.
    case attributedString(NSAttributedString, configuration: Printer.PageConfiguration = .standard)
    
    /// JPG or PNG image data.
    case imageData(Data)
    
    /// An JPG or PNG image file at a certain URL.
    case imageFile(at: URL?)
    
    /// PDF document data.
    case pdfData(Data)
    
    /// A PDF document file at a certain URL.
    case pdfFile(at: URL?)
    
    /// A plain string with a PDF page configuration.
    case string(String, configuration: Printer.PageConfiguration = .standard)
    
    /// Get a quick look url to the item, if any.
    public var quickLookUrl: URL? {
        switch self {
        case .attributedString: nil
        case .imageData: nil
        case .imageFile(let url): url
        case .pdfData: nil
        case .pdfFile(let url): url
        case .string: nil
        }
    }
}

@available(iOS 16.0, macOS 13.0, *)
@available(*, deprecated, message: "The PrintItem concept is deprecated. Use the Printer class directly.")
public extension PrintItem {
    
    /**
     Try to create an ``PrintItem/imageData(_:)`` print item
     by rendering the provided view to an image.
     
     - Parameters:
       - view: The view to print.
       - scale: The scale to print in, by default `2`.
     */
    @MainActor
    static func view<Content: View>(
        _ view: Content,
        withScale scale: CGFloat = 2
    ) throws -> PrintItem {
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        guard let data = renderer.imageData else { throw Printer.PrintError.invalidViewData }
        return imageData(data)
    }
}
#endif
