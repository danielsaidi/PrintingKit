//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import PrintingKit
import QuickLook
import SwiftUI

@MainActor
struct ContentView: View {
    
    private let printer = Printer()
    
    @State var quickLookUrl: URL?
    @State var isGreenCheckmarkSelected = true
    @State var text = "Type text here..."
    
    var body: some View {
        NavigationStack {
            List {
                fileSection
                dataSection
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
    
    var fileSection: some View {
        Section("Files") {
            fileListItem("Print PDF file", .pdf, "document", "pdf")
            fileListItem("Print JPG file", .image, "clouds", "jpg")
            fileListItem("Print PNG file", .image, "graphics", "png")
        }
    }
    
    var dataSection: some View {
        Section("Data") {
            fileDataListItem("Print PDF data", .pdf, "document", "pdf")
            fileDataListItem("Print JPG data", .image, "clouds", "jpg")
            fileDataListItem("Print PNG data", .image, "graphics", "png")
        }
    }
    
    var textSection: some View {
        Section("Text") {
            Label(
                title: { TextField("Type text here...", text: $text, axis: .vertical) },
                icon: { Image.textInput }
            )
            printButton("Print as string", .text) {
                tryPrint {
                    try printer.printString(text, config: .standard)
                }
            }
            printButton("Print as attributed string", .text) {
                tryPrint {
                    try printer.printAttributedString(.init(string: text), config: .standard)
                }
            }
        }
    }
    
    var viewSection: some View {
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
                tryPrint {
                    try printer.printView(printableView, withScale: 200)
                }
            }
        }
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
        guard let url = url(for: file, ext) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    func url(for file: String, _ ext: String) -> URL? {
        Bundle.main.url(forResource: file, withExtension: ext)
    }
    
    func fileListItem(
        _ title: String,
        _ icon: Image,
        _ fileName: String,
        _ fileExtension: String
    ) -> some View {
        let url = url(for: fileName, fileExtension)
        return HStack {
            printButton(title, icon) {
                tryPrint { try printer.printFile(at: url) }
            }
            if let url {
                quickLookButton(for: url)
            }
        }
    }
    
    func fileDataListItem(
        _ title: String,
        _ icon: Image,
        _ fileName: String,
        _ fileExtension: String
    ) -> some View {
        let url = url(for: fileName, fileExtension)
        return HStack {
            printButton(title, icon) {
                tryPrint {
                    guard let url else { return }
                    let data = try Data(contentsOf: url)
                    try printer.printData(data, withFileExtension: fileExtension)
                }
            }
            if let url {
                quickLookButton(for: url)
            }
        }
    }
}

private extension ContentView {
    
    func printButton(
        _ title: String,
        _ icon: Image,
        _ action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Label { Text(title) } icon: { icon }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(.rect)
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
    
    func tryPrint(_ action: @escaping () throws -> Void) {
        do {
            try action()
        } catch {
            print(error)
        }
    }
}

#Preview {
    
    ContentView()
}
