//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael & Diana Pascucci on 12/21/22.
//
// Challenges:
// 1. Add a header to the third section, saying "Amount per person"
// 2. Add another section showing the total amount for the check - i.e., the original amount plus tip value, without dividing by the number of people.
// 3. Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options - everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
// 4. Rather than having to type .currency(code: Locale.current.currencyCode ?? "USD") in two places, can you make a new property to store the currency formatter? You'll need to give your property a specific return type in order to keep the rest of your code happy: FloatingPointFormatStyle<Double>.Currency. You can find that for yourself using Xcode's Quick Help window - open up the right-hand navigator, then select the Quick Help inspector, and finally click select the .currency code. You'll see Xcode displays <Value> rather than <Double>, because this thing is able to display other kinds of floating-point numbers too, but here we need Double.

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var checkAmount = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let localizedCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    // let tipPercentages = [10, 15, 20, 25, 0]
    
    var checkTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localizedCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    // Picker("Tip percentage", selection: $tipPercentage) {
                    //     ForEach(tipPercentages, id: \.self) {
                    //         Text($0, format: .percent)
                    //     }
                    // }
                    // .pickerStyle(.segmented)
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) { percent in
                            Text("\(percent, format: .percent)")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(checkTotal, format: localizedCurrency)
                } header: {
                    Text("Total check plus tip")
                }
                
                Section {
                    Text(totalPerPerson, format: localizedCurrency)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
