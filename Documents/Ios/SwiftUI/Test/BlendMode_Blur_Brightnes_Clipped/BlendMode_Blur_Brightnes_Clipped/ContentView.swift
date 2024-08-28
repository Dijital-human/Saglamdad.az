//
//  ContentView.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Blend Mode Test - 1").font(Font.custom("Optima", size: 32))
            Text("Giris")
            HStack(spacing: 20.0){
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.color)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.colorBurn)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.colorDodge)
                }
                
            }
            HStack(spacing: 10.0){
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.difference)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.exclusion)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.hardLight)
                }
            }
            HStack(spacing: 10.0){
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.hue)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.lighten)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.luminosity)
                }
            }
            HStack(spacing: 10.0){
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.multiply)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.normal)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.overlay)
                }
            }
            HStack(spacing: 10.0){
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.plusDarker)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.plusLighter)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.saturation)
                }
            }
            HStack(spacing: 10.0){
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.screen)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.softLight)
                }
                ZStack{
                    Color.red.frame(width: 100, height: 100)
                    Color.blue.frame(width: 100, height: 100).offset(x: 20.0, y: 20.0).blendMode(.sourceAtop)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
