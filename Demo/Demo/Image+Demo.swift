//
//  Image+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-12-14.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Image {
    
    static let checkmark = symbol("checkmark")
    static let eye = symbol("eye")
    static let image = symbol("photo")
    static let pdf = symbol("doc.richtext")
    static let text = symbol("textformat.abc")
    static let textInput = symbol("character.cursor.ibeam")
    static let view = symbol("apps.iphone")
    static let xmark = symbol("xmark")
    
    static var checkmarkBadge: some View {
        Image.checkmark
            .badge(iconColor: .white, badgeColor: .green)
    }
    
    static var xmarkBadge: some View {
        Image.xmark
            .badge(iconColor: .white, badgeColor: .red)
    }
    
    static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}

private extension Image {
    
    func badge(
        iconColor: Color,
        badgeColor: Color
    ) -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .symbolVariant(.circle)
            .symbolVariant(.fill)
            .foregroundStyle(iconColor, badgeColor)
            .shadow(radius: 2, x: 0, y: 2)
    }
}
