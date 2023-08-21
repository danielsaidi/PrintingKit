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
    
    static let eye = symbol("eye")
    static let image = symbol("photo")
    static let pdf = symbol("doc.richtext")
    
    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}

struct ContentView: View, PrinterView {
    
    @State
    private var quickLookUrl: URL?
    
    var body: some View {
        NavigationStack {
            List {
                Section("Files") {
                    listItem("Print PDF file", .pdf, printItem(for: "document", "pdf"))
                    listItem("Print JPG file", .image, printItem(for: "clouds", "jpg"))
                    listItem("Print PNG file", .image, printItem(for: "graphics", "png"))
                }
                Section("Data") {
                    listItem("Print PDF data", .pdf, printItemWithData(from: "document", "pdf"))
                    listItem("Print JPG data", .image, printItemWithData(from: "clouds", "jpg"))
                    listItem("Print PNG data", .image, printItemWithData(from: "graphics", "png"))
                }
            }
            .buttonStyle(.plain)
            .navigationTitle("PrinterKit Demo")
        }
        .quickLookPreview($quickLookUrl)
    }
}

private extension PrintItem {
    
    var quickLookUrl: URL? {
        switch self {
        case .imageData: return nil
        case .imageFile(let url): return url
        case .pdfData: return nil
        case .pdfFile(let url): return url
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
        if canPrintItem(item) {
            HStack {
                printButton(title, icon, item)
                if let url = item?.quickLookUrl {
                    quickLookButton(for: url)
                }
            }
        }
    }
    
    func printButton(
        _ title: String,
        _ icon: Image,
        _ item: PrintItem?
    ) -> some View {
        Button {
            if let item {
                tryPrint(item)
            } else {
                print("Invalid item")
            }
        } label: {
            Label { Text(title) } icon: { icon }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }.disabled(item == nil)
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
    
    func tryPrint(_ item: PrintItem) {
        do {
            try printItem(item)
        } catch {
            print(error)
        }
    }
    
    func printItem(for file: String, _ ext: String) -> PrintItem {
        let url = printItemUrl(for: file, ext)
        switch ext {
        case "pdf": return .pdfFile(at: url)
        default: return .imageFile(at: url)
        }
    }
    
    func printItemWithData(from file: String, _ ext: String) -> PrintItem? {
        guard
            let url = printItemUrl(for: file, ext),
            let data = try? Data(contentsOf: url)
        else { return nil }
        switch ext {
        case "pdf": return .pdfData(data)
        default: return .imageData(data)
        }
    }
    
    func printItemUrl(for file: String, _ ext: String) -> URL? {
        Bundle.main.url(forResource: file, withExtension: ext)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
