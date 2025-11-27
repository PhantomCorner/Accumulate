//
//  NumericTextField.swift
//  accumulate
//
//  Created by Allen Wu on 27/11/2025.
//

import SwiftUI

/// A view modifier that limits text input to numeric values only
struct NumericInputModifier: ViewModifier {
    @Binding var text: String
    let allowDecimal: Bool
    
    func body(content: Content) -> some View {
        content
            .keyboardType(allowDecimal ? .decimalPad : .numberPad)
            .onChange(of: text) { oldValue, newValue in
                let allowedCharacters = allowDecimal ? "0123456789." : "0123456789"
                let filtered = newValue.filter { allowedCharacters.contains($0) }
                
                if allowDecimal {
                    // Ensure only one decimal point
                    let components = filtered.components(separatedBy: ".")
                    if components.count > 2 {
                        text = oldValue
                        return
                    }
                }
                
                text = filtered
            }
    }
}

extension View {
    /// Limits text field input to numbers only
    /// - Parameter text: The text binding to filter
    /// - Parameter allowDecimal: Whether to allow decimal point (default: true)
    func numericInput(_ text: Binding<String>, allowDecimal: Bool = true) -> some View {
        self.modifier(NumericInputModifier(text: text, allowDecimal: allowDecimal))
    }
}
