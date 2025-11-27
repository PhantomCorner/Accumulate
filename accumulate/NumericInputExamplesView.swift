//
//  NumericInputExamplesView.swift
//  accumulate
//
//  Created by Allen Wu on 27/11/2025.
//

import SwiftUI

struct NumericInputExamplesView: View {
    @State private var decimalNumber: String = ""
    @State private var integerOnly: String = ""
    @State private var salary: String = ""
    
    var body: some View {
        Form {
            Section("Decimal Numbers (e.g., 5.5, 123.45)") {
                TextField("Amount with decimals", text: $decimalNumber)
                    .numericInput($decimalNumber, allowDecimal: true)
                
                Text("Value: \(decimalNumber)")
                    .foregroundStyle(.secondary)
            }
            
            Section("Integer Only (e.g., 5, 123)") {
                TextField("Whole numbers only", text: $integerOnly)
                    .numericInput($integerOnly, allowDecimal: false)
                
                Text("Value: \(integerOnly)")
                    .foregroundStyle(.secondary)
            }
            
            Section("Example: Salary") {
                TextField("Enter salary", text: $salary)
                    .numericInput($salary, allowDecimal: true)
                
                if let salaryValue = Double(salary), salaryValue > 0 {
                    Text("Formatted: $\(salaryValue, specifier: "%.2f")")
                        .foregroundStyle(.green)
                }
            }
            
            Section("Features") {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Only numbers allowed", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Label("Decimal pad keyboard", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Label("One decimal point max", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Label("No letters or symbols", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
                .font(.caption)
            }
        }
        .navigationTitle("Numeric Input Demo")
    }
}

#Preview {
    NavigationStack {
        NumericInputExamplesView()
    }
}
