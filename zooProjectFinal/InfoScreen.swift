//
//  InfoScreen.swift
//  zooProjectFinal
//
//  Created by Faizah Almalki on 21/05/1445 AH.
//

import SwiftUI

struct InfoScreen: View {
@State private var isScreenPresented = false

    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            Image("H1")
                .offset(y:-310)
            ZStack {
                Circle()
                    .foregroundColor(Color("Color5"))
                    .blur(radius: 100)
            
                Image("frame2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }                .offset(y:-130)
            
            

           Text("الفائز هو الاسد !")
                    .font(.custom("Ithra-Bold", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Color2"))
                    .offset(y:-300)
            
                Text(" ماذا تعرف عن ملك الغابه ؟")
                         .font(.custom("Ithra-Light", size: 20))
                         .multilineTextAlignment(.center)
                         .foregroundColor(Color("Color2"))
                         .offset(y:-250)

            
            VStack(spacing: 0){
                Text(" نوع الحيوان:\nهو حيوان ثدي يتبع فصيلة السنوريات")                         .font(.custom("Ithra-Light", size: 12))
                         .multilineTextAlignment(.center)
                         .foregroundColor(Color("Color2"))
                Text("التغذية\nيتغذى الأسد بشكل رئيسي على اللحوم، وهو من أبرز المفترسين في المملكة الحيوانية.")                       .font(.custom("Ithra-Light", size: 12))
                         .multilineTextAlignment(.center)
                         .foregroundColor(Color("Color2"))
                Text("التكاثر\nتتم عملية التزاوج على مدار العام، وتستمر فترة الحمل لحوالي 110 أيام.\n")                     .font(.custom("Ithra-Light", size: 12))
                         .multilineTextAlignment(.center)
                         .foregroundColor(Color("Color2"))
                Text("الأهمية الثقافية\nيشغل الأسد مكانة خاصة في الثقافة والرموزية، حيث يُعتبر رمزًا للقوة والشجاعة في عدة ثقافات.")                  .font(.custom("Ithra-Light", size: 12))
                         .multilineTextAlignment(.center)
                         .foregroundColor(Color("Color2"))
                Text("الحياة الاجتماعية\nيعيش الأسود في مجموعات اجتماعية تعرف بالروؤس، ويكونون عادةً في فرق يقودها ذكر.")             .font(.custom("Ithra-Light", size: 12))
                         .multilineTextAlignment(.center)
                         .foregroundColor(Color("Color2"))
                
            
                
                
            }.offset(y:100)
            Button(action: {isScreenPresented = true
            }) {
                
                    Text("العب مرة أخرى")
                        .font(.custom("Ithra-Bold", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color("BackgroundColor"))
                        .frame(width: 200, height: 50)
                        .background(Color("Color2"))
                        .cornerRadius(80)
            }  .offset(y:300)
            //هنا مفروض يكون يقدر يرجع يررسل دعوه
                .fullScreenCover(isPresented: $isScreenPresented) {
                    introRegisteration()
                    //
                }


            }

 
            }
       
            }
            
                
                
            

        
    


#Preview {
    InfoScreen()
}
