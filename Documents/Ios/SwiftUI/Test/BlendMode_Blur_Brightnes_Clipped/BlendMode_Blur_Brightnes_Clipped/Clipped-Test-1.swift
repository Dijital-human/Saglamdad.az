//
//  Clipped-Test-1.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct Clipped_Test_1: View {
    var body: some View {
        VStack(spacing: 10.0){
            Text("Clipped Test - 1").font(.largeTitle)
            Text("Giris").font(.title).foregroundStyle(.gray)
            HStack{
                VStack{
                    Text("Ilkin")
                    Circle().fill(.red).frame(width: 150, height: 80).border(Color.black, width: 3).offset(x: 20.0, y: 20.0)
                }
                VStack{
                    Text("Clipped")
                    Circle().fill(.red).frame(width: 150, height: 80).border(Color.black, width: 3).offset(x: 20.0, y: 20.0).clipped()
                }
            }
            HStack{
                Image("img-1").resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100).clipped()
                Image("img-1").resizable().frame(width: 100, height: 100).offset(x:20.0, y: 20.0).clipped()
            }
        }
    }
}

#Preview {
    Clipped_Test_1()
}
