//
//  Let'sPlayScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI
import Firebase
struct LetsPlayScreen: View {
    
     var  invitionKey:String
   
    @State private var moveToSecondPage = false
    
    let ref = Database.database().reference().child("Invations")
    ///var onDismiss: () -> Void
    let userName: String
    
    var body: some View {
                    // Call the function when the view appear
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text("الجولة الأولى :منافسة الاسود ")
                    .font(
                        Font.custom("Ithra", size: 18)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Color2"))
                    .padding(.top, -10)
                    .frame(width: 251, height: 33)
                
                Text("تحدى أسد وصديقه إلى سباق مثير لاكتشاف واصطياد القطة")
                    .frame(width: 350, height: 33)
                    .foregroundColor(Color("Color2"))
                    .font(Font.custom("Ithra", size: 13))
                Text("من يكون أسرع في رؤية والقبض على فريسته، سيكون الفائز")
                    .frame(width: 350, height: 33)
                    .foregroundColor(Color("Color2"))
                    .font(Font.custom("Ithra", size: 13))
                
                
                
                
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

                        
                        Image("frame2")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .offset(x: 0)
                        .scaleEffect(x: -1, y: 1)


                        

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
                        Text("صديقك")
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
                            .font(Font.custom("Ithra", size: 20))
                            .foregroundColor(Color("Color2"))
                            .multilineTextAlignment(.trailing)
                        
                    }
                    
                    
                }
                Text("في انتظار قبول الدعوة")
                    .foregroundColor(Color("Color2"))
                    .font(Font.custom("Ithra", size: 13))
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("Color2"))) // Set progress color to orange
                       .frame(width: 100, height: 100)
               
              //  readInvitionState(invitionKey:invitionKey)
               
            }.fullScreenCover(isPresented: $moveToSecondPage, content: {
                contentView(invitionsKey: invitionKey, userName:userName)
            })
            
            .onAppear {
       
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            print("none \(invitionKey)")
                readInvitionState(invitionKey: invitionKey)
                                  
                                        }
                             
                          
                      }
         
           
             
            
            

        }
        
       
       

      
    }
    func readInvitionState(invitionKey:String){
        
        
        print("test!!!!!!!!!!!!!!!!!!")
        guard !invitionKey.isEmpty else {
               // Handle the empty string case
               return
           }
        
        print("the KEY IS \(invitionKey)")
        var isAccepted = "false"
        ref.child(invitionKey).child("isAccepted").observeSingleEvent(of: .value){ snapshot in
            print("\(snapshot)")
            if let isAcceptedValue = snapshot.value as? String {
                
              // isAccepted=isAcceptedValue
                if isAcceptedValue == "true" {
                    DispatchQueue.main.async {
                        moveToSecondPage = true
                        print("the value now is TRUE!!! ")
                                   }
                }else{
                    moveToSecondPage=false
                    print("the value now is FALSE!!!")
                    
                }
            }
            
        }
    }
    
}

struct LetsPlayScreen_Previews: PreviewProvider {
    static var previews: some View {
        LetsPlayScreen(invitionKey: "YourDummyInvitationKey",userName: "user name")
    }
}
