//
//  ContentView.swift
//  SpiltMaar
//
//  Created by Priyankshu Sheet on 07/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection / 100)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                Form {
                    Section (header: Text ("Enter Your Bill Amount").font(.headline).foregroundColor(.blue)) {
                        TextField ("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .foregroundColor(.black)
                            .accentColor(.blue)
                    }
                    
                    Section (header: Text ("Select Number of Persons").font(.headline).foregroundColor(.blue)) {
                        Picker ("Number of Persons", selection: $numberOfPeople) {
                            ForEach (2..<21) {
                                Text("\($0) Persons")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 320, height: 100)
                        .clipped()
                        .background(Color.mint.opacity(0.36))
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                        .padding(.horizontal, 100)
                    }
                    
                    Section (header: Text("Wanna Give Some Tip ???").font(.headline).foregroundColor(.blue)) {
                        Picker ("Tip Percentage", selection: $tipPercentage) {
                            ForEach (tipPercentages, id: \.self) {
                                Text ($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 320 , height: 36)
                        .foregroundColor(.orange)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                    }
                    
                    Section (header: Text("Amount per person").font(.headline).foregroundColor(.blue)) {
                        Text (totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .frame(width: 90 , height: 36)
                            .font(.title2)
                            .foregroundStyle(.green)
                            .padding()
                            .background(Color.gray.opacity(0.07))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("SplitMaar")
                
                .padding()
                .toolbar {
                    if amountIsFocused {
                        Button ("Done") {
                            amountIsFocused = false
                        }
                    }
                }
                .foregroundColor(.accentColor)
            }
        }
    }
}

#Preview {
    ContentView()
}
