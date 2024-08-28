//
//  GrayScale_Test_1.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct GrayScale_Test_1: View {
    @State private var slider = 0.5
    @State private var opacityslider = 0.5

    var body: some View {
        ZStack{
            Color.red.opacity(opacityslider)
            
            VStack{
                Text("GrayScale Test - 1").font(.largeTitle)
                Text("Giris").font(.title).foregroundStyle(.gray)
                
                HStack{
                    Color.red.frame(width: 50, height: 50).grayscale(0.0).overlay {
                        Text("0.0 %")
                    }
                    Color.red.frame(width: 50, height: 50).grayscale(0.3).overlay {
                        Text("0.3 %")
                    }
                    Color.red.frame(width: 50, height: 50).grayscale(0.50).overlay {
                        Text("0.50 %")
                    }
                    Color.red.frame(width: 50, height: 50).grayscale(0.6).overlay {
                        Text("0.6 %")
                    }
                    Color.red.frame(width: 50, height: 50).grayscale(1).overlay {
                        Text("1 %")
                    }
                }.foregroundStyle(.white).font(.footnote)
                VStack{
                    Slider(value: $slider, in: 0...1, step: 0.1).padding(.horizontal).accentColor(.blue.opacity(slider))
                    HStack{
                        Color.blue.frame(width: 100, height: 100).grayscale(slider).overlay {
                            Text("\(slider,specifier: "%.2f")")
                        }
                        Color.red.frame(width: 100, height: 100).grayscale(slider).overlay {
                            Text("\(slider,specifier: "%.2f")")
                        }
                        Color.orange.frame(width: 100, height: 100).grayscale(slider).overlay {
                            Text("\(slider,specifier: "%.2f")")
                        }
                    }
                    HStack{
                        Image("img-1").resizable().frame(width: 100, height: 100).opacity(opacityslider)
                        Slider(value: $opacityslider, in: 0...1, step: 0.1)
                    }.padding()
                }
                
            }
        }
    }
}

#Preview {
    GrayScale_Test_1()
}
