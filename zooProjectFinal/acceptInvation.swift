//
//  acceptInvation.swift
//  zooProjectFinal
//
//  Created by maryam on 15/05/1445 AH.
//

import SwiftUI
import Firebase
import FirebaseDatabase

let ref = Database.database().reference().child("Invations")
class invationViewList: ObservableObject {
    @Published var userInvationss: [invations] = []
    
    init() {
        //fetchData()
    }
    
    
    func fetchInvaition(accepterUserName: String) {
        ref.queryOrdered(byChild: "accepterCatID").queryEqual(toValue: "\(accepterUserName)").observe(.value) { snapshot in
            var userInvations = [invations]()
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let userDict = snapshot.value as? [String: Any],
                   let inavtionKey = userDict["invationKey"] as? String,
                   let senderLionKey = userDict["senderLionKey"] as? String,
                   let isAccepted = userDict["isAccepted"] as? String,
                   let accepterCatID = userDict["accepterCatID"] as? String {
                    if let inavtionKeyUUID = UUID(uuidString: inavtionKey) {
                        let invation = invations(invationKey: inavtionKeyUUID, senderLionKey: senderLionKey, isAccepted: isAccepted, accepterCatID: accepterCatID)
                        if invation.isAccepted == "false"{
                            userInvations.append(invation)
                        }
                            
                    } else {
                        print("Invalid UUID format for accepterCatID: \(accepterCatID)")
                    }
                }
                
                // self.userInvationss = userInvations
            }
            self.userInvationss = userInvations
            
            // Use 'self' explicitly to resolve the issue
        }
    }
}

struct acceptInvation: View {
    let refInvtions = Database.database().reference().child("Invations")
    
    @State private var isAcceptedSucessfully = false
    
    @ObservedObject var invationList: invationViewList
    
    @State private var selectedInvitation: invations?

     let userName: String

     init(userName: String) {
         self.userName = userName
         self.invationList = invationViewList()
         self.invationList.fetchInvaition(accepterUserName: userName)
     }
    
    

    var body: some View {
        List(invationList.userInvationss) { invation in
                        Text("Invitation from: \(invation.senderLionKey)")
            Button(action: {
                self.selectedInvitation = invation
                print("clciked")
                let userInvitionKey=selectedInvitation?.invationKey.uuidString
                
                updateInvitionState(invationKey: userInvitionKey ?? "", isApproved:"true")

            }) {
                Text("قبول")
                    .frame(width: 100, height: 15)
                    .font(.custom("Ithra-Bold", size: 16))
                
                    .fontWeight(.bold)
                    .foregroundColor(Color("BackgroundColor"))
                    .padding()
                    .background(Color("Color2"))
                    .cornerRadius(80)
 
            } .fullScreenCover(isPresented: $isAcceptedSucessfully, content: {
                let invationKeyString = selectedInvitation?.invationKey.uuidString
            
                LionAR(invitionsKey: invationKeyString ?? "")
                //send the invition key and the type of user
             })
                        // Add more Text views for other properties if needed
                    }
        .onAppear{
            self.invationList.fetchInvaition(accepterUserName: userName) 
        }
    }
    func updateInvitionState(invationKey:String,isApproved: String){
        let updateData = ["isAccepted": isApproved]
        refInvtions.child(invationKey).updateChildValues(updateData){
            (error, _) in
                        if let error = error {
                            print("Error updating invitation approval status: \(error.localizedDescription)")
                        } else {
                            
                            print("Invitation approval status updated successfully")
                            isAcceptedSucessfully=true
                        }
        }
        
    }
}

struct acceptInvation_Previews: PreviewProvider {
    @State static private var dummystringUserName = ""
    static var previews: some View {
        acceptInvation(userName: dummystringUserName)
    }
}
