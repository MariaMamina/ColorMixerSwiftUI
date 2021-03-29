//
//  ContentView.swift
//  ColorMixerSwiftUI
//
//  Created by Maria Mamina on 29.03.2021.
//

import SwiftUI


struct ContentView: View {
    
    @State private var redColor = 0.0
    @State private var greenColor = 0.0
    @State private var blueColor = 0.0
    
    var body: some View {
        ZStack {
            Color(white: 0.9)
                .ignoresSafeArea(.all)
            VStack (spacing: 20) {
                
                Color(red: redColor/255,
                      green: greenColor/255,
                      blue: blueColor/255)
                    .frame(height: 150)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 3))
                
                ColorSetting(value: $redColor, color: .red)
                ColorSetting(value: $greenColor, color: .green)
                ColorSetting(value: $blueColor, color: .blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSetting: View {
    @Binding var value: Double
    
    var color: Color
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .frame(width: 35)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
            ColorValueTextField(value: $value)
        }
    }
}

struct ColorValueTextField: View {
    @Binding var value: Double
    @State private var alertPresented = false
    var body: some View {
        TextField("0",
                  value: $value,
                  formatter: NumberFormatter(),
                  onEditingChanged: { (changed) in
                    if !changed {
                        if value > 255 {
                            alertPresented.toggle()
                            value = 255 }
                        else if value < 0 {
                            alertPresented.toggle()
                            value = 0
                        }
                    }
                  })
            .alert(isPresented: $alertPresented,
                   content: {
                    Alert(title: Text("Incorrect color value"),
                          message: Text("Please, enter corect color value. The value must be greater than 0 and less than 255"))
                   })
            .frame(width: 50)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
