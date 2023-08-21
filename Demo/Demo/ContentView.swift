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
    
    var body: some View {
        NavigationStack {
            List {
                content
            }
            .navigationTitle("PrinterKit Demo")
        }
        .quickLookPreview($quickLookUrl)
    }
}

private extension ContentView {
    
    @ViewBuilder
    var content: some View {
        Group {
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
            if canPrintViews() {
                Section("View") {
                    printContent
                    Button("Print this view") {
                        printViewAsTask(printContent)
                    }
                }
            }
        }.buttonStyle(.plain)
    }
    
    var printContent: some View {
        ZStack {
            Color.black
            Color.green.opacity(0.4)
            Image.checkmarkBadge
                .padding(20)
        }.cornerRadius(10)
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
