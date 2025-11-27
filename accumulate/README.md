# Daily Salary Progress Tracker

A clean, focused iOS app that tracks your daily salary earnings in real-time.

## 🎯 Features

### Two-Step Setup
1. **Step 1**: Enter your monthly salary
2. **Step 2**: Enter your working days per month

### Real-Time Progress Display
- **Circular Progress Ring**: Beautiful animated ring showing today's progress
- **Live Calculations**: Updates based on current time of day
- **Earnings Display**: Shows how much you've earned today

### Input Validation
- ✅ Numeric-only input (no letters or special characters)
- ✅ Decimal support for salary amounts
- ✅ Integer-only for working days
- ✅ iOS decimal pad keyboard
- ✅ Real-time filtering

## 📱 How It Works

### Step 1: Monthly Salary
- Enter your gross monthly salary
- Supports decimals (e.g., 5000.50)
- Shows green dollar icon

### Step 2: Working Days
- Enter number of working days per month
- Typically 20-22 days
- Integers only (no decimals)
- Shows blue calendar icon

### Progress View
- **Circular Progress Ring**: Animated from 0% to current time of day
- **Daily Salary**: Calculated as Monthly Salary ÷ Working Days
- **Earned Today**: Daily Salary × Progress Percentage
- **Automatic Time Calculation**: Based on current time (0:00 = 0%, 12:00 = 50%, 23:59 = 100%)

## 🎨 Design

- Clean, minimal interface
- Smooth animations and transitions
- Gradient progress ring (blue to purple)
- Clear visual hierarchy
- Rounded corners and modern styling

## 📂 File Structure

```
accumulate/
├── SalaryProgressView.swift       // ⭐ Main app view
├── NumericTextField.swift         // Numeric input validation
├── ContentView.swift              // App entry point
└── accumulateApp.swift           // SwiftUI app
```

## 🚀 Usage

1. Run the app
2. Enter your monthly salary
3. Tap "Next"
4. Enter your working days
5. Tap "Calculate"
6. View your daily progress!
7. Tap "Start Over" to recalculate

## 💡 Example

**Input:**
- Monthly Salary: $6000
- Working Days: 20

**Output:**
- Daily Salary: $300.00
- At 12:00 PM: Earned Today: $150.00 (50% progress)
- At 5:00 PM: Earned Today: $212.50 (70.8% progress)

## ⚙️ Technical Details

### Progress Calculation
```swift
// Get time elapsed since start of day
let now = Date()
let startOfDay = calendar.startOfDay(for: now)
let timeElapsed = now.timeIntervalSince(startOfDay)
let totalSeconds = 24 * 60 * 60

// Calculate percentage
let progress = timeElapsed / totalSeconds
```

### Daily Salary Formula
```
Daily Salary = Monthly Salary ÷ Working Days
Earned Today = Daily Salary × Progress (0.0 to 1.0)
```

## 🎉 Clean Implementation

All test views and examples have been removed. This is a production-ready, focused app with:
- Single purpose: track daily salary progress
- Clean codebase
- Reusable components
- Smooth user experience

---

Built with SwiftUI • iOS 17+ • Swift 6+
