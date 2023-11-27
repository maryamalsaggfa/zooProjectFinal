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
                    .padding(.top, -250)
                    .frame(width: 251, height: 33)
                Text("VS")
                    .font(Font.custom("Poppins", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.63, green: 0.86, blue: 0.94))                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Color1").opacity(0.2)))
                HStack {
                                    Image("frame1")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    
                                    Image("frame2")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                              
                
            }    }
    }
}

#Preview {
    Let_sPlayScreen()
}
