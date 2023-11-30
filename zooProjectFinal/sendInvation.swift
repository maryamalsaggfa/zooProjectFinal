//
//  sendInvation.swift
//  zooProjectFinal
//
//  Created by maryam on 15/05/1445 AH.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseDatabase

struct sendInvation: View {
    @State private var senderUserName:String=""
    @State private var accepterUserName:String=""
    
    @State private var errorMessageUserName: String?
    @State private var errorMessage: String?
    
   var ref = Database.database().reference().child("Invations")
    var playersRef = Database.database().reference().child("Players")

    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            ZStack {
                Circle()
                    .foregroundColor(Color("Color5"))
                    .blur(radius: 100)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }                    .offset(y: -250)
            
            VStack{
              
                
                Text("استعد لبدء المغامرة!                                                                                          قم بدعوة صديقك ليكون جزءًا من التجربة الرائعة.")
                    .font(.custom("Ithra-Light", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Color1"))
                    .padding(.bottom ,270 )
            }
                
                Text(errorMessageUserName ?? "")
                    .foregroundColor(.red)
                    .font(
                        Font.custom("Poppins", size: 12
                                   )
                        .weight(.bold)
                    )
                Text(errorMessage ?? "")
                    .foregroundColor(.red)
                    .font(
                        Font.custom("Poppins", size: 12
                                   )
                        .weight(.bold)
                    )
                VStack{
                    TextField("أدخل اسمك",text: $senderUserName)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 20)
                        .foregroundColor( Color("Color2") )
                        .font(.custom("Ithra-Bold", size: 16))

                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("Color1"), lineWidth: 2)
                                        .frame(width: 350, height: 40)
                                )
                    TextField("أدخل اسم صديقك ",text: $accepterUserName)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 20)
                        .foregroundColor( Color("Color2") )
                        .font(.custom("Ithra-Light", size: 16))

                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("Color1"), lineWidth: 2)
                                        .frame(width: 350,
                                            height: 40)
                                )
                    
                    Button(action:{
                        //send inavtion
                        checkAndUpload()
                    }){
                        Text("أرسل الدعوه ")
                            .frame(width: 200, height: 15)
                            .font(.custom("Ithra-Bold", size: 16))

                            .fontWeight(.bold)
                            .foregroundColor(Color("BackgroundColor"))
                            .padding()
                            .background(Color("Color2"))
                            .cornerRadius(80)
                            .offset(y: 80)

                    }
                }
                
            }
        }
    
    func checkAndUpload(){
        if (senderUserName.isEmpty || accepterUserName.isEmpty){
            errorMessageUserName="fill all the text filed"
        }
        else{
            errorMessageUserName=nil
            
        }
        
        if errorMessageUserName==nil{
            let newInvation = invations(invationKey:UUID(), senderLionKey: senderUserName, isAccepted: "false", accepterCatID:accepterUserName)
            
            uploadInvations(invations: newInvation)
        }
}
    func uploadInvations(invations:invations){
        let senderQuery = playersRef
            .queryOrdered(byChild: "userName")
            .queryEqual(toValue: "\(invations.senderLionKey)")
        
            let accepterQuery = playersRef
            .queryOrdered(byChild: "userName")
            .queryEqual(toValue: "\(invations.accepterCatID)")
        
        senderQuery.observeSingleEvent(of:.value){
            senderSnapshot in
            accepterQuery.observeSingleEvent(of: .value){
                accepterSnapshot in
                if senderSnapshot.exists() && accepterSnapshot.exists(){
                    let invitationKeyString = invations.invationKey.uuidString
                    ref.child(invitationKeyString).setValue([
                        "invationKey":invitationKeyString,
                        "senderLionKey":invations.senderLionKey,
                        "accepterCatID":invations.accepterCatID,
                        "isAccepted":invations.isAccepted
                    ])
                }
                
                
                
                else {
                    // Players with the specified lionKey and catID do not exist
                    print("Players not found. Invitation not uploaded.")
                    errorMessage = "Players not found. Invitation not uploaded."
                }
            }
        }
      
      
    }

}

#Preview {
    sendInvation()
}
