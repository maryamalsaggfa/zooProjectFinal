//
//  Let'sPlayScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI
import Firebase
struct LetsPlayScreen: View {
    
    @State public var  invitionKey:String
   
    @State private var moveToSecondPage = false
    
    let ref = Database.database().reference().child("Invations")
    
   
    
    var body: some View {
                    // Call the function when the view appear
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text("في انتظار قبول الدعوة")
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
                    ProgressView()
                }
               
              //  readInvitionState(invitionKey:invitionKey)
               
            }.fullScreenCover(isPresented: $moveToSecondPage, content: {
                LionAR(invitionsKey: invitionKey)
            })
            
            .onAppear {
                          if !moveToSecondPage {
                              Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                                            readInvitionState(invitionKey: invitionKey)
                                        }
                             
                          }
                      }
         
           
             
            
            

        }
        
       
       

      
    }
    func readInvitionState(invitionKey:String){
        guard !invitionKey.isEmpty else {
               // Handle the empty string case
               return
           }
        var isAccepted = "false"
        ref.child(invitionKey).child(isAccepted).observeSingleEvent(of: .value){ snapshot in
            
            if let isAcceptedValue = snapshot.value as? String {
                
              // isAccepted=isAcceptedValue
                if isAcceptedValue == "true" {
                    DispatchQueue.main.async {
                        moveToSecondPage = true
                                   }
                }else{
                    moveToSecondPage=false
                    
                }
            }
            
        }
    }
    
}

#Preview {
    LetsPlayScreen(invitionKey:"")
}
