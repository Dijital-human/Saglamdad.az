//
//  Color_Multiplay_Test_1.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct Color_Multiplay_Test_1: View {
    var body: some View {
        VStack{
            Text("Color Multiplay Test - 1").font(.largeTitle)
            Text("Giris").font(.title).foregroundStyle(.gray)
            
            HStack{
                Color.red.frame(width: 100, height: 100)
                Color.blue.frame(width: 100, height: 100).offset(x: -50, y: 0.0).blendMode(.darken)
                Color.blue.frame(width: 100, height: 100)

                Color.green.frame(width: 100, height: 100).offset(x: -50, y: 0.0).blendMode(.difference)
            }
            HStack{
                Color.red.frame(width: 100, height: 100)
                Color.yellow.frame(width: 100, height: 100)
                Color.red.frame(width: 100, height: 100).colorMultiply(.yellow)
            }
            HStack{
                Color.blue.frame(width: 100, height: 100)
                Color.yellow.frame(width: 100, height: 100)
                Color.blue.frame(width: 100, height: 100).colorMultiply(.yellow)
            }
            HStack{
                Color.orange.frame(width: 100, height: 100)
                Color.yellow.frame(width: 100, height: 100)
                Color.orange.frame(width: 100, height: 100).colorMultiply(.yellow)
            }
            HStack{
                Color.red.frame(width: 100, height: 100)
                Color.green.frame(width: 100, height: 100)
                Color.red.frame(width: 100, height: 100).colorMultiply(.green)
            }
            HStack{
                Color.cyan.frame(width: 100, height: 100)
                Color.yellow.frame(width: 100, height: 100)
                Color.cyan.frame(width: 100, height: 100).colorMultiply(.yellow)
            }
            
        }
    }
}

#Preview {
    Color_Multiplay_Test_1()
}
