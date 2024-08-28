//
//  Button_Test_1.swift
//  BlendMode_Blur_Brightnes_Clipped
//
//  Created by Famil Mustafayev on 07.08.24.
//

import SwiftUI

struct Button_Test_1: View {
    var body: some View {
        ZStack{
            Color.cyan.ignoresSafeArea()
            VStack{
                Text("Buttons").font(Font.custom("Optima", size: 32)).bold()
                HStack{
                    Button(action: {}, label: {
                        Text("Save").padding(.init(top: 10, leading: 60, bottom: 10, trailing: 60)).foregroundStyle(.white)
                    }).background(Color.red).clipShape(RoundedRectangle(cornerRadius: 25.0))
                    Button("Save") {}
                        .frame(width: 150, height: 40).background().clipShape(Capsule())
                }
                HStack{
                    Button(action: {}, label: {
                        Text("Sign In").padding(.init(top: 16, leading: 50, bottom: 16, trailing: 50))
                    }).background(Rectangle().stroke(.red, lineWidth: 2))
                    Button(action: {}, label: {
                        Text("Sign In").padding(.init(top: 16, leading: 40, bottom: 16, trailing: 40))
                    }).background(Rectangle().stroke(.red,lineWidth: 2))
                }
                HStack{
                    Button(action: {}, label: {
                        Text("Sign In").padding(.init(top: 16, leading: 50, bottom: 16, trailing: 50)).foregroundStyle(.white)
                    }).background(Color.red.mask(Capsule()))
                    
                    Button(action: {}, label: {
                        Text("Sign In").padding(.init(top: 16, leading: 40, bottom: 16, trailing: 40)).foregroundStyle(.white)
                    }).background(Color.red.clipShape(RoundedRectangle(cornerRadius: 25.0)))
                }
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.down").font(.largeTitle).padding().foregroundColor(.white)
                    }).background(Circle())
                    
                    
                    Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.up").font(.largeTitle).padding().foregroundColor(.white)
                    }).background(Circle())
                    Button(action: {}, label: {
                        Image(systemName: "trash.square").font(.largeTitle).padding().foregroundColor(.white)
                    }).background(Circle())
                    Button(action: {}, label: {
                        Image(systemName: "person.crop.square.badge.camera.fill").font(.largeTitle).padding().foregroundStyle(.white)
                    }).background(Capsule())
                }
                
                
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "network").font(.largeTitle).padding().foregroundColor(.black)
                    }).background(Circle().stroke(.white))
                    
                    
                    Button(action: {}, label: {
                        Image(systemName: "wifi.square").font(.largeTitle).padding().foregroundColor(.black)
                    }).background(Circle().stroke(.white))
                    Button(action: {}, label: {
                        Image(systemName: "trash.square").font(.largeTitle).padding().foregroundColor(.black)
                    }).background(Circle().stroke(.white))
                    Button(action: {}, label: {
                        Image(systemName: "chart.bar").font(.largeTitle).padding().foregroundStyle(.black)
                    }).background(Capsule().stroke(.white))
                }
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "network").font(.largeTitle).padding().foregroundColor(.white).frame(width: 100)
                    }).background(Capsule().stroke(.red))
                    
                    
                    Button(action: {}, label: {
                        Image(systemName: "wifi.square").font(.largeTitle).padding().foregroundColor(.white).frame(width: 100)
                    }).background(Capsule().stroke(.blue))
                    
                    Button(action: {}, label: {
                        Image(systemName: "chart.bar").font(.largeTitle).padding().foregroundStyle(.white).frame(width: 100)
                    }).background(Capsule().stroke(.green))
                }
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis").font(.largeTitle).padding().foregroundColor(.white).frame(width: 120)
                    }).background(RoundedRectangle(cornerRadius: 25.0).stroke(.red))
                    
                    
                    Button(action: {}, label: {
                        Image(systemName: "trash").font(.largeTitle).padding().foregroundColor(.white).frame(width: 120)
                    }).background(RoundedRectangle(cornerRadius: 25.0).stroke(.blue))
                    
                    Button(action: {}, label: {
                        Image(systemName: "folder").font(.largeTitle).padding().foregroundStyle(.white).frame(width: 120)
                    }).background(RoundedRectangle(cornerRadius: 25.0).stroke(.green))
                }
                HStack{
                    Button(action: {}, label: {
                        Text("Button").frame(width: 140, height: 60)
                    }).background(RoundedRectangle(cornerRadius: 25.0).stroke(.red)).foregroundStyle(.white)
                    Button(action: {}, label: {
                        Text("Button").frame(width: 140, height: 60).foregroundStyle(.white)
                    }).background(RoundedRectangle(cornerRadius: 25.0).stroke(.blue, lineWidth: 3))
                }
                HStack{
                    Button(action: {}, label: {
                        Text("Button").frame(width: 140, height: 40).foregroundStyle(.white)
                    }).background(RoundedRectangle(cornerRadius: 40).stroke(.red,style: StrokeStyle(lineWidth: 2.0, dash: [3.10])))
                    Button(action: {}, label: {
                        Text("Button").frame(width: 140, height: 40).foregroundStyle(.white)
                    }).background(RoundedRectangle(cornerRadius: 40).stroke(.blue,style: StrokeStyle(lineWidth: 2.0,lineCap: .round, dash: [3.10])))
                }
            }
        }
    }
}

#Preview {
    Button_Test_1()
}
