//
//  ContentView.swift
//  iOSdemo
//
//  Created by IntSur on 2025/1/30.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var isAmountFieldFocused: Bool
    
    let tipPercentages = [0, 10, 20, 30, 40]
    let userCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var totalAmount: Double {
        amount / 100 * (100 + Double(tipPercentage))
    }
    
    var perPersonAmount: Double {
        Double(amount / 100 * (100 + Double(tipPercentage)) / Double(numberOfPeople + 1))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .currency(code: userCurrency))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFieldFocused)
                    
                    Picker("Select number of people", selection: $numberOfPeople) {
                        ForEach(1..<30) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("HOW MUCH TIP DO YOU WANT TO LEAVE") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total AMOUNT") {
                    Text(totalAmount, format: .currency(code: userCurrency))
                }
                
                Section("AMOUNT PER PERSON") {
                    Text(perPersonAmount, format: .currency(code: userCurrency))
                }
            }
            .navigationTitle("Tonight's Bill 🥗")
            .toolbar {
                Button("Done") {
                    isAmountFieldFocused = false
                }
                Button("Edit") {
                    isAmountFieldFocused = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
