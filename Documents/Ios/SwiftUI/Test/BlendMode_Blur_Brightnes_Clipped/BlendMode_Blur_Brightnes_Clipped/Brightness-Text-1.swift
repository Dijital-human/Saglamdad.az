//
//  Brightness-Text-1.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct Brightness_Text_1: View {
    private var bright =  [0, 0.2, 0.4, 0.5, 0.8, 1]
    var body: some View {
        VStack(spacing: 10.0){
            Text("Brightness Text - 1").font(Font.custom("Optima", size: 32))
            Text("Giris").font(.title).foregroundStyle(.gray)
            
            HStack(spacing:10.0){
                ForEach(bright, id: \.self){item in
                    Color.red.frame(width: 50, height: 50).brightness(item).overlay {
                        Text("\(String(item))")
                    }

                }


            }
        }
    }
}

#Preview {
    Brightness_Text_1()
}
