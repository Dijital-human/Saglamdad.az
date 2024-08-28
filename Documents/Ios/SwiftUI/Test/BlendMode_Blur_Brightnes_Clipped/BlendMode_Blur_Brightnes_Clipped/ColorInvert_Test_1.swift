//
//  ColorInvert_Test_1.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct ColorInvert_Test_1: View {
    var body: some View {
        VStack{
            Text("ColorInvert Test - 1").font(.largeTitle)
            Text("Giris").font(.title).foregroundStyle(.gray)
            HStack{
                Color.red.frame(width: 100, height: 100)
                Color.red.frame(width: 100, height: 100).colorInvert()
            }
            HStack{
                Color.blue.frame(width: 100, height: 100)
                Color.blue.frame(width: 100, height: 100).colorInvert()
            }
            HStack{
                Color.orange.frame(width: 100, height: 100)
                Color.orange.frame(width: 100, height: 100).colorInvert()
            }
            HStack{
                Color.pink.frame(width: 100, height: 100)
                Color.pink.frame(width: 100, height: 100).colorInvert()
            }
            HStack{
                Color.yellow.frame(width: 100, height: 100)
                Color.yellow.frame(width: 100, height: 100).colorInvert()
            }
        }
    }
}

#Preview {
    ColorInvert_Test_1()
}
