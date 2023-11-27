//
//  Let'sPlayScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI

struct Let_sPlayScreen: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Text("عيش تجربة الصيد في الأدغال")
                    .font(
                        Font.custom("Poppins", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Color2"))
                    .padding(.top, -10)
                    .frame(width: 251, height: 33)
                
                
                
                Text("VS")
                    .font(Font.custom("Poppins", size: 10))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Color3"))

                    .frame(width: 45, height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Color1").opacity(0.2)))
                    .offset(y: 200)

             
                
                HStack {
                    ZStack{
                        Circle()
                               .foregroundColor(Color("Color3"))
                               .blur(radius: 60)
                               .offset(x: -100)

                    .frame(width: 250, height:400)

                        
                        Image("frame1")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x: 0)


                        

                    }
                    Spacer()
                    ZStack{
                        Circle() 
                               .foregroundColor(Color("Color2"))
                               .blur(radius: 60)
                               .offset(x: 100)

                    .frame(width: 250, height:400)
                        
                        Spacer()
                        Image("frame2")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .offset(x: -10)

                    }
                        
                    }
                HStack {
                    HStack {
                        Image("PL1")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .background(Color("Color4"))
                            .clipShape(Circle())
                            .offset(x: -60)
                            .padding(.top, -80)
                        Text("Player 1")
                            .offset(x: -60)
                            .padding(.top, -60)
                            .font(Font.custom("Inter", size: 20))
                            .foregroundColor(Color("Color3"))
                    }
                    
                    HStack {
                        Image("PL2")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .background(Color("Color4"))
                            .clipShape(Circle())
                            .offset(x: 110)
                            .padding(.top, -80)
                        Text(" أنت ")
                            .offset(x: 5)
                            .padding(.top, -60)
                            .font(Font.custom("Inter", size: 20))
                            .foregroundColor(Color("Color2"))
                            .multilineTextAlignment(.trailing)
                        
                    }
                }
                                
            }    }
    }
}

#Preview {
    Let_sPlayScreen()
}
