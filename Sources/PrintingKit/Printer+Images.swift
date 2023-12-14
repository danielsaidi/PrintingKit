import Foundation

extension Printer {
    
    /// Whether or not the printer can print images.
    var canPrintImages: Bool {
        #if os(iOS)
        return true
        #else
        return false
        #endif
    }
}
