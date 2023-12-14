//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-08-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import PrintingKit
import QuickLook
import SwiftUI

struct ContentView: View {
    
    private let printer = Printer()
    
    @State
    private var quickLookUrl: URL?
    
    @State
    private var isGreenCheckmarkSelected = true
    
    @State
    private var text = "Type here to change the text to print"
    
    var body: some View {
        NavigationStack {
            List {
                Section("Files") {
                    listItem("Print PDF file", .pdf, fileItem(for: "document", "pdf"))
                    listItem("Print JPG file (iOS only)", .image, fileItem(for: "clouds", "jpg"))
                    listItem("Print PNG file (iOS only)", .image, fileItem(for: "graphics", "png"))
                }
                Section("Data") {
                    listItem("Print PDF data", .pdf, dataItem(for: "document", "pdf"))
                    listItem("Print JPG data (iOS only)", .image, dataItem(for: "clouds", "jpg"))
                    listItem("Print PNG data (iOS only)", .image, dataItem(for: "graphics", "png"))
                }
                Section("Text") {
                    printButton("Print text as a string", .text) {
                        try? printer.print(.string(text, configuration: .standard))
                    }
                    printButton("Print text as an attributed string", .text) {
                        let str = NSAttributedString(string: text)
                        try? printer.print(.attributedString(str, configuration: .standard))
                    }
                }
                Section {
                    TextField("Type text here and tap the print button...", text: $text, axis: .vertical)
                }
                Section("View") {
                    printButton("Print the selected view (iOS only)", .view) {
                        do {
                            try printer.print(.view(printableView, withScale: 200))
                        } catch {
                            print(error)
                        }
                    }
                    
                }
                Section {
                    Picker("Select which view to print:", selection: $isGreenCheckmarkSelected) {
                        Image.checkmarkBadge.tag(true)
                        Image.xmarkBadge.tag(false)
                    }
                    .pickerStyle(.menu)
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
    
    @ViewBuilder
    func listItem(
        _ title: String,
        _ icon: Image,
        _ item: PrintItem?
    ) -> some View {
        HStack {
            printButton(title, icon) {
                if let item {
                    tryPrint(item)
                } else {
                    print("Invalid item")
                }
            }
            .disabled(!printer.canPrint(item))
            
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
