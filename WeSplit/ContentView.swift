//
//  ContentView.swift
//  WeSplit
//
//  Created by Md. Shoibur Rahman Khan Sifat on 9/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var peoples: Int = 0
    @State private var tipPercentage: Int = 10
    @FocusState private var isFocused: Bool
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        return (checkAmount * (tipSelection / 100)) + checkAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(peoples + 2)
        let tipSelection = Double(tipPercentage)
        return ((checkAmount * (tipSelection / 100)) + checkAmount) / peopleCount
    }
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 30, 0]
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                Section{
                    Picker("Peoples", selection: $peoples){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total Amount"){
                    Text(totalAmount,format: .currency(code: "USD"))
                }
                Section("Amount per person"){
                    Text(totalPerPerson,format: .currency(code: "USD"))
                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if isFocused{
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
        
    }
}
