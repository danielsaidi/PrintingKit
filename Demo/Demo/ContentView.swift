//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-08-21.
//

import PrintingKit
import QuickLook
import SwiftUI

extension Image {
    
    static let checkmark = symbol("checkmark")
    static let eye = symbol("eye")
    static let image = symbol("photo")
    static let pdf = symbol("doc.richtext")
    static let text = symbol("textformat.abc")
    static let view = symbol("square")
    
    static var checkmarkBadge: some View {
        Image.checkmark
            .resizable()
            .aspectRatio(contentMode: .fill)
            .symbolVariant(.circle)
            .symbolVariant(.fill)
            .foregroundStyle(.white, .green)
            .shadow(radius: 2, x: 0, y: 2)
    }
    
    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}

struct ContentView: View, PrinterView {
    
    @State
    private var quickLookUrl: URL?
    
    @State
    private var text = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Files") {
                    listItem("Print PDF file", .pdf, fileItem(for: "document", "pdf"))
                    listItem("Print JPG file", .image, fileItem(for: "clouds", "jpg"))
                    listItem("Print PNG file", .image, fileItem(for: "graphics", "png"))
                }
                Section("Data") {
                    listItem("Print PDF file data", .pdf, dataItem(for: "document", "pdf"))
                    listItem("Print JPG file data", .image, dataItem(for: "clouds", "jpg"))
                    listItem("Print PNG file data", .image, dataItem(for: "graphics", "png"))
                }
                textSection
                viewSection
            }
            .buttonStyle(.plain)
            .navigationTitle("PrinterKit Demo")
        }
        .quickLookPreview($quickLookUrl)
    }
}

private extension ContentView {
    
    var textSection: some View {
        Section("Text") {
            TextField("Type text here and tap the print button", text: $text, axis: .vertical)
                .lineLimit(3, reservesSpace: true)
            Group {
                printButton("Print as plain text", .text) {
                    try? printItem(.string(text, configuration: .standard))
                }
                printButton("Print as attributed string", .text) {
                    let str = NSAttributedString(string: text)
                    try? printItem(.attributedString(str, configuration: .standard))
                }
            }
            .disabled(text.isEmpty)
        }
    }
    
    var viewContent: some View {
        ZStack {
            Color.black
            Color.green.opacity(0.4)
            Image.checkmarkBadge
                .padding(20)
        }.cornerRadius(10)
    }
    
    @ViewBuilder
    var viewSection: some View {
        if canPrintViews() {
            Section("View") {
                viewContent
                printButton("Print this view", .view) {
                    printViewInTask(viewContent)
                }
            }
        }
    }
}

private extension PrintItem {
    
    var quickLookUrl: URL? {
        switch self {
        case .attributedString: return nil
        case .imageData: return nil
        case .imageFile(let url): return url
        case .pdfData: return nil
        case .pdfFile(let url): return url
        case .string: return nil
        }
    }
}

private extension ContentView {
    
    @ViewBuilder
    func listItem(
        _ title: String,
        _ icon: Image,
        _ item: PrintItem?
    ) -> some View {
        if canPrint(item) {
            HStack {
                printButton(title, icon) {
                    if let item {
                        tryPrint(item)
                    } else {
                        print("Invalid item")
                    }
                }.disabled(item == nil)
                if let url = item?.quickLookUrl {
                    quickLookButton(for: url)
                }
            }
        }
    }
    
    func printButton(
        _ title: String,
        _ icon: Image,
        _ action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Label { Text(title) } icon: { icon }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
    }
    
    func dataItem(for file: String, _ ext: String) -> PrintItem? {
        guard
            let url = fileUrl(for: file, ext),
            let data = try? Data(contentsOf: url)
        else { return nil }
        switch ext {
        case "pdf": return .pdfData(data)
        default: return .imageData(data)
        }
    }
    
    func fileItem(for file: String, _ ext: String) -> PrintItem {
        let url = fileUrl(for: file, ext)
        switch ext {
        case "pdf": return .pdfFile(at: url)
        default: return .imageFile(at: url)
        }
    }
    
    func quickLookButton(
        for url: URL
    ) -> some View {
        Button {
            quickLookUrl = url
        } label: {
            Image.eye
        }
    }
    
    func fileUrl(for file: String, _ ext: String) -> URL? {
        Bundle.main.url(forResource: file, withExtension: ext)
    }
    
    func tryPrint(_ item: PrintItem) {
        do {
            try printItem(item)
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
