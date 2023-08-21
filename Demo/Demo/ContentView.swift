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
                Section("Printing") {
                    listItem("Print PDF", .pdf, printItem(for: "document", "pdf"))
                    listItem("Print JPG", .image, printItem(for: "clouds", "jpg"))
                    listItem("Print PNG", .image, printItem(for: "graphics", "png"))
                }
            }
            .buttonStyle(.plain)
            .navigationTitle("PrinterKit Demo")
        }
        .quickLookPreview($quickLookUrl)
    }
}

private extension ContentView {
    
    func listItem(
        _ title: String,
        _ icon: Image,
        _ item: PrintItem
    ) -> some View {
        HStack {
            printButton(title, icon, item)
            if let url = item.sourceUrl {
                quickLookButton(for: url)
            }
        }
    }
    
    func printButton(
        _ title: String,
        _ icon: Image,
        _ item: PrintItem
    ) -> some View {
        Button {
            tryPrint(item)
        } label: {
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
        case "pdf": return .pdf(at: url)
        default: return .image(at: url)
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
