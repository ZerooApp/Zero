//
//  RoundedBorder.swift
//  Zero
//
//  Created by Test on 10/09/2025.
//

import SwiftUI
extension View {
    ///
    /// Adds an inner rounded border around a view with a specified radius, style and line width.
    ///
    /// This function allows you to apply a rounded border to any view using a customizable `ShapeStyle` for the border color and appearance. You can also specify the line width of the border.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Text("Hello, World!")
    ///             .padding()
    ///             .roundedBorder(radius: 8, style: .blue, lineWidth: 2)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - radius: A `CGFloat` value that defines the radius of the rounded corners.
    ///   - style: A generic `ShapeStyle` that defines the appearance of the border (e.g., Color, LinearGradient, etc.).
    ///   - lineWidth: A `CGFloat` value that specifies the width of the border line. The default value is `1`.
    ///
    /// - Returns: A `some View` that represents the modified view with the rounded border applied.
    ///
    public func roundedBorder<Style: ShapeStyle>(
        radius: CGFloat,
        style: Style,
        lineWidth: CGFloat = 1
    ) -> some View {
        modifier(
            RoundedBorder(
                radius: radius,
                style: style,
                lineWidth: lineWidth
            )
        )
    }
}

fileprivate struct RoundedBorder<Style: ShapeStyle>: ViewModifier {
    // MARK: - Inputs
    let radius: CGFloat
    let style: Style
    let lineWidth: CGFloat
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .clipShape(
                .rect(cornerRadius: radius)
            )
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(style, lineWidth: lineWidth)
            }
    }
}

