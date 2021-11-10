//
//  ContentView.swift
//  Currency App
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var currencyList = [String]()
    @State var input = "100"
    @State var base = "USD"
    @FocusState private var inputIsFocused: Bool
    
    func makeRequest(showAll: Bool, currencies: [String] = ["USD", "GBP", "EUR"]) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(input)") { currency in
            //print("ContentView", currency.rates)
            var tempList = [String]()
            
            for currency in currency.rates {
                
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f",currency.value))")
                } else if currencies.contains(currency.key)  {
                    tempList.append("\(currency.key) \(String(format: "%.2f",currency.value))")
                }
                
                
                
                tempList.sort()
            }
            currencyList.self = tempList
            
        }
    }
    
    var body: some View {
        VStack() {
            HStack {
                Text("Currencies")
                    .font(.system(size: 30))
                    .bold()
                
                Image(systemName: "eurosign.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                
            }
            List {
                ForEach(currencyList, id: \.self) { currency in
                    Text(currency)
                    
                }
            }
            
            VStack {
                Rectangle()
                    .frame(height: 8.0)
                    .foregroundColor(.blue)
                    .opacity(0.90)
                
                TextField("Enter an amount" ,text: $input)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
                    .autocapitalization(.allCharacters)
                
                
                TextField("Enter a currency" ,text: $base)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .focused($inputIsFocused)
                
                
                Button("Convert!") {
                    makeRequest(showAll: true)
                    inputIsFocused = false
                }.padding()
            }
            
        }.onAppear() {
            makeRequest(showAll: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
