//
//  ContentView.swift
//  TipTrick!
//
//  Created by Benjamin Heflin on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercent = 20
    
    @State private var currentCurrencyCode = FloatingPointFormatStyle<Double>.Currency.init(code: Locale.current.currencyCode ?? "USD")
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentChoices = [10, 15, 20, 25, 0]
    
    var getGrandTotal: Double {
        let tipSelection = Double(tipPercent)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        getGrandTotal / Double(numPeople + 2)
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercent) {
                        ForEach(tipPercentChoices, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(getGrandTotal, format: currentCurrencyCode)
                }
                header : {
                    Text("Total amount for check:")
                }
                Section {
                    Text(totalPerPerson, format: currentCurrencyCode)
                        .padding()
                        .foregroundColor(tipPercent == 0 ? .red : .primary)
                }
                header : {
                    Text("Amount per person:")
                }
            }
            .navigationTitle("TipTrick!")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
