//
//  SalaryFormView.swift
//  accumulate
//
//  Created by Allen Wu on 27/11/2025.
//

import SwiftUI

struct SalaryFormView: View {
    @State private var salary: String = ""
    @State private var hours: String = ""
    
    var body: some View {
        Form {
            Section("Monthly Salary") {
                TextField("Enter salary", text: $salary)
                    .numericInput($salary, allowDecimal: true)
            }
            
            Section("Hours per Day") {
                TextField("Enter hours", text: $hours)
                    .numericInput($hours, allowDecimal: true)
            }
            
            Section {
                Button("Calculate") {
                    calculate()
                }
                .disabled(salary.isEmpty || hours.isEmpty)
            }
        }
        .navigationTitle("Salary Info")
    }
    
    private func calculate() {
        if let salaryValue = Double(salary),
           let hoursValue = Double(hours) {
            let hourlyRate = salaryValue / (hoursValue * 22)
            print("Hourly Rate: \(hourlyRate)")
        }
    }
}

#Preview {
    NavigationStack {
        SalaryFormView()
    }
}
