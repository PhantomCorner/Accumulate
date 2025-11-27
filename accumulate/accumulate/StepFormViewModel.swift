//
//  StepFormViewModel.swift
//  accumulate
//
//  Created by Allen Wu on 27/11/2025.
//

import Foundation
import Observation

@Observable
class StepFormViewModel {
    var currentStep = 0
    var monthlySalary: String = ""
    var hoursPerDay: String = ""
    
    let totalSteps = 2
    
    var canProceed: Bool {
        switch currentStep {
        case 0:
            return !monthlySalary.isEmpty && Double(monthlySalary) != nil
        case 1:
            return !hoursPerDay.isEmpty && Double(hoursPerDay) != nil
        default:
            return false
        }
    }
    
    func nextStep() {
        if currentStep < totalSteps - 1 {
            currentStep += 1
        } else {
            submitForm()
        }
    }
    
    func previousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }
    
    func submitForm() {
        print("Monthly Salary: \(monthlySalary)")
        print("Hours per Day: \(hoursPerDay)")
        
        // Calculate hourly rate (assuming 22 working days per month)
        if let salary = Double(monthlySalary),
           let hours = Double(hoursPerDay) {
            let hourlyRate = salary / (hours * 22)
            print("Hourly Rate: \(hourlyRate)")
        }
    }
    
    func calculateHourlyRate() -> Double? {
        guard let salary = Double(monthlySalary),
              let hours = Double(hoursPerDay) else {
            return nil
        }
        return salary / (hours * 22)
    }
}
