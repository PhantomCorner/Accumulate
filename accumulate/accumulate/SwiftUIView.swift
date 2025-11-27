//
//  StepFormView.swift
//  accumulate
//
//  Created by Allen Wu on 27/11/2025.
//

import SwiftUI

struct StepFormView: View {
    @State private var currentStep = 0
    @State private var monthlySalary: String = ""
    @State private var hoursPerDay: String = ""
    @FocusState private var focusedField: Field?
    private let totalSteps = 2
    
    enum Field {
        case salary
        case hours
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Progress indicator
                ProgressView(value: Double(currentStep), total: Double(totalSteps))
                    .padding(.horizontal)
                
                Text("Step \(currentStep + 1) of \(totalSteps)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                // Form content based on current step
                Group {
                    switch currentStep {
                    case 0:
                        salaryStep
                    case 1:
                        hoursStep
                    default:
                        EmptyView()
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                .animation(.easeInOut, value: currentStep)
                
                Spacer()
                
                // Navigation buttons
                HStack(spacing: 16) {
                    if currentStep > 0 {
                        Button(action: previousStep) {
                            Label("Back", systemImage: "chevron.left")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    Button(action: nextStep) {
                        if currentStep == totalSteps - 1 {
                            Label("Finish", systemImage: "checkmark")
                                .frame(maxWidth: .infinity)
                        } else {
                            Label("Next", systemImage: "chevron.right")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!canProceed)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Salary Information")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
        }
    }
    
    // MARK: - Step Views
    
    private var salaryStep: some View {
        VStack(spacing: 20) {
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
            
            Text("Number 1")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextField("Enter amount", text: $monthlySalary)
                .numericInput($monthlySalary, allowDecimal: true)
                .textFieldStyle(.roundedBorder)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .focused($focusedField, equals: .salary)
             // test
            Text("Enter your gross monthly salary")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var hoursStep: some View {
        VStack(spacing: 20) {
            Image(systemName: "clock.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("How many hours do you work per day?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextField("Enter hours", text: $hoursPerDay)
                .numericInput($hoursPerDay, allowDecimal: true)
                .textFieldStyle(.roundedBorder)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .focused($focusedField, equals: .hours)
            
            Text("Average hours per workday")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Navigation Logic
    
    private var canProceed: Bool {
        switch currentStep {
        case 0:
            return !monthlySalary.isEmpty && Double(monthlySalary) != nil
        case 1:
            return !hoursPerDay.isEmpty && Double(hoursPerDay) != nil
        default:
            return false
        }
    }
    
    private func nextStep() {
        if currentStep < totalSteps - 1 {
            currentStep += 1
        } else {
            // Form completed
            submitForm()
        }
    }
    
    private func previousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }
    
    private func submitForm() {
        // Handle form submission
        print("Monthly Salary: \(monthlySalary)")
        print("Hours per Day: \(hoursPerDay)")
        
        // Calculate hourly rate (assuming 22 working days per month)
        if let salary = Double(monthlySalary),
           let hours = Double(hoursPerDay) {
            let hourlyRate = salary / (hours * 22)
            print("Hourly Rate: \(hourlyRate)")
        }
        
        // You can add navigation or other actions here
    }
}

#Preview {
    StepFormView()
}
