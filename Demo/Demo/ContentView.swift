//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import PrintingKit
import QuickLook
import SwiftUI

@MainActor
struct ContentView: View {
    
    private let printer = Printer()
    
    @State
    private var quickLookUrl: URL?
    
    @State
    private var isGreenCheckmarkSelected = true
    
    @State
    private var text = "Type text here..."
    
    private var attributedString: NSAttributedString {
        .init(string: text)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Files") {
                    listItem("Print PDF file", .pdf, fileItem(for: "document", "pdf"))
                    listItem("Print JPG file", .image, fileItem(for: "clouds", "jpg"))
                    listItem("Print PNG file", .image, fileItem(for: "graphics", "png"))
                }
                Section("Data") {
                    listItem("Print PDF data", .pdf, dataItem(for: "document", "pdf"))
                    listItem("Print JPG data", .image, dataItem(for: "clouds", "jpg"))
                    listItem("Print PNG data", .image, dataItem(for: "graphics", "png"))
                }
                Section("Text") {
                    Label(
                        title: { TextField("Type text here...", text: $text, axis: .vertical) },
                        icon: { Image.textInput }
                    )
                    listItem("Print text as string", .text, .string(text))
                    listItem("Print text as attributed string", .text, .attributedString(attributedString))
                }
                Section("View") {
                    Label(
                        title: {
                            Picker("Select view:", selection: $isGreenCheckmarkSelected) {
                                Image.checkmarkBadge.tag(true)
                                Image.xmarkBadge.tag(false)
                            }
                            .pickerStyle(.menu)
                        },
                        icon: { Image.image }
                    )
                    
                    printButton("Print the selected view", .view) {
                        let view = try? PrintItem.view(printableView, withScale: 200)
                        tryPrintItem(view)
                    }
                }
                Section("Preview") {
                    printableView.padding()
                }
            }
            .buttonStyle(.plain)
            .navigationTitle("PrinterKit Demo")
        }
        .quickLookPreview($quickLookUrl)
    }
}

private extension ContentView {
    
    @ViewBuilder
    var printableView: some View {
        if isGreenCheckmarkSelected {
            Image.checkmarkBadge
        } else {
            Image.xmarkBadge
        }
    }
}

private extension ContentView {
    
    func data(for file: String, _ ext: String) -> Data? {
        guard let url = fileUrl(for: file, ext) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    func dataItem(for file: String, _ ext: String) -> PrintItem? {
        guard let data = data(for: file, ext) else { return nil }
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
    
    func fileUrl(for file: String, _ ext: String) -> URL? {
        Bundle.main.url(forResource: file, withExtension: ext)
    }
    
    @ViewBuilder
    func listItem(
        _ title: String,
        _ icon: Image,
        _ item: PrintItem?
    ) -> some View {
        HStack {
            printButton(title, icon) {
                if let item {
                    tryPrintItem(item)
                } else {
                    print("Invalid item")
                }
            }
            if let url = item?.quickLookUrl {
                quickLookButton(for: url)
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
    
    func quickLookButton(
        for url: URL
    ) -> some View {
        Button {
            quickLookUrl = url
        } label: {
            Image.eye
        }
    }
    
    func tryPrintItem(_ item: PrintItem?) {
        guard let item else { return }
        do {
            try printer.print(item)
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
