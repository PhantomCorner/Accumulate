//
//  SalaryProgressView.swift
//  accumulate
//
//  Created by Allen Wu on 27/11/2025.
//

import SwiftUI

struct SalaryProgressView: View {
    @State private var currentStep = 1
    @State private var monthlySalary: String = ""
    @State private var workingDays: String = ""
    @State private var showProgress = false
    
    // For the progress ring
    @State private var progress: Double = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !showProgress {
                    // Input Steps
                    inputView
                } else {
                    // Progress Display
                    progressView
                }
            }
            .navigationTitle(showProgress ? "Daily Progress" : "Setup")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Input View
    
    private var inputView: some View {
        VStack(spacing: 40) {
            // Progress indicator
            HStack(spacing: 12) {
                Circle()
                    .fill(currentStep >= 1 ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 12, height: 12)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 2)
                
                Circle()
                    .fill(currentStep >= 2 ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 12, height: 12)
            }
            .padding(.horizontal, 60)
            .padding(.top, 20)
            
            Spacer()
            
            // Step Content
            if currentStep == 1 {
                step1View
            } else {
                step2View
            }
            
            Spacer()
            
            // Navigation Buttons
            navigationButtons
        }
        .padding()
    }
    
    private var step1View: some View {
        VStack(spacing: 24) {
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)
            
            Text("What is your monthly salary?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextField("Enter amount", text: $monthlySalary)
                .numericInput($monthlySalary, allowDecimal: true)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 32, weight: .medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .frame(height: 60)
            
            Text("Enter your gross monthly salary")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var step2View: some View {
        VStack(spacing: 24) {
            Image(systemName: "calendar")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            
            Text("How many working days per month?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextField("Enter days", text: $workingDays)
                .numericInput($workingDays, allowDecimal: false)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 32, weight: .medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .frame(height: 60)
            
            Text("Typically 20-22 days per month")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 16) {
            if currentStep > 1 {
                Button(action: {
                    withAnimation {
                        currentStep -= 1
                    }
                }) {
                    Label("Back", systemImage: "chevron.left")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            
            Button(action: {
                if currentStep == 1 {
                    withAnimation {
                        currentStep = 2
                    }
                } else {
                    // Show progress view
                    withAnimation {
                        showProgress = true
                        startProgress()
                    }
                }
            }) {
                Label(currentStep == 1 ? "Next" : "Calculate", 
                      systemImage: currentStep == 1 ? "chevron.right" : "chart.bar.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!canProceed)
        }
        .padding(.horizontal)
    }
    
    private var canProceed: Bool {
        if currentStep == 1 {
            return !monthlySalary.isEmpty && Double(monthlySalary) != nil
        } else {
            return !workingDays.isEmpty && Int(workingDays) != nil
        }
    }
    
    // MARK: - Progress View
    
    private var progressView: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Circular Progress Ring
            ZStack {
                // Background ring
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 250, height: 250)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 250, height: 250)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.5), value: progress)
                
                // Center content
                VStack(spacing: 8) {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 48, weight: .bold))
                    
                    Text("of daily salary")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            // Salary Information
            VStack(spacing: 16) {
                HStack {
                    Text("Monthly Salary:")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("$\(monthlySalary)")
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Working Days:")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(workingDays) days")
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                HStack {
                    Text("Daily Salary:")
                        .font(.headline)
                    Spacer()
                    Text("$\(dailySalary, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundStyle(.green)
                }
                
                HStack {
                    Text("Earned Today:")
                        .font(.headline)
                    Spacer()
                    Text("$\(earnedToday, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    showProgress = false
                    currentStep = 1
                    monthlySalary = ""
                    workingDays = ""
                    progress = 0
                }
            }) {
                Label("Start Over", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)
        }
        .padding()
    }
    
    // MARK: - Calculations
    
    private var dailySalary: Double {
        guard let salary = Double(monthlySalary),
              let days = Double(workingDays),
              days > 0 else {
            return 0
        }
        return salary / days
    }
    
    private var earnedToday: Double {
        dailySalary * progress
    }
    
    private func startProgress() {
        // Simulate progress based on time of day
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let timeElapsed = now.timeIntervalSince(startOfDay)
        let totalSeconds = 24.0 * 60.0 * 60.0 // seconds in a day
        
        // Calculate progress (0.0 to 1.0)
        let calculatedProgress = min(timeElapsed / totalSeconds, 1.0)
        
        // Animate to the calculated progress
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            progress = calculatedProgress
        }
    }
}

#Preview {
    SalaryProgressView()
}
