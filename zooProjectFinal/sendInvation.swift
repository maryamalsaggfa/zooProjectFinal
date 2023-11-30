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
        Text("Add your friend")
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
            TextField("enter your user name",text: $senderUserName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("enter your friend user name",text: $accepterUserName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action:{
                //send inavtion
                checkAndUpload()
            }){
                Text("Send Invation")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
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
