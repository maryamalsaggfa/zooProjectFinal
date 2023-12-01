import SwiftUI
import Firebase
import FirebaseDatabase

struct Invation {
    var invationKey: UUID
    var senderLionKey: String
    var isAccepted: String
    var accepterCatID: String
}
var currentUser=""
struct sendInvation: View {
    @State private var senderUserName: String = ""
    @State private var accepterUserName: String = ""
    
    @State private var isInvationsListsTapped = false
    
    @State private var errorMessageUserName: String?
    @State private var errorMessage: String?
    
    var ref = Database.database().reference().child("Invations")
    var playersRef = Database.database().reference().child("Players")

    var body: some View {
        ZStack {
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
            }
            .offset(y: -250)
            
            VStack {
                Text("استعد لبدء المغامرة!                                                                                          قم بدعوة صديقك ليكون جزءًا من التجربة الرائعة.")
                    .font(.custom("Ithra-Light", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Color1"))
                    .padding(.bottom, 20)
                
                Text(errorMessageUserName ?? "")
                    .foregroundColor(.red)
                    .font(
                        Font.custom("Poppins", size: 12)
                            .weight(.bold)
                    )
                
                Text(errorMessage ?? "")
                    .foregroundColor(.red)
                    .font(
                        Font.custom("Poppins", size: 12)
                            .weight(.bold)
                    )
                
                VStack {
                    TextField("أدخل اسمك", text: $senderUserName)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 20)
                        .foregroundColor(Color("Color2"))
                        .font(.custom("Ithra-Bold", size: 16))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Color1"), lineWidth: 2)
                                .frame(width: 350, height: 40)
                        )
                    
                    TextField("أدخل اسم صديقك ", text: $accepterUserName)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 20)
                        .foregroundColor(Color("Color2"))
                        .font(.custom("Ithra-Light", size: 16))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Color1"), lineWidth: 2)
                                .frame(width: 350, height: 40)
                        )
                    
                    Button(action: {
                        // send invitation
                        checkAndUpload()
                    }) {
                        Text("أرسل الدعوه ")
                            .frame(width: 200, height: 15)
                            .font(.custom("Ithra-Bold", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color("BackgroundColor"))
                            .padding()
                            .background(Color("Color2"))
                            .cornerRadius(80)
                            .offset(y: 10) // Adjusted the offset
                    }
                    Button(action: {
                        // send invitation
                        isInvationsListsTapped=true
                        
                    }) {
                        Text("إظهار جميع الدعوات المرسلة لك")
                            .frame(width: 250, height: 15)
                            .font(.custom("Ithra-Bold", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.white))
                            .padding()
                            
                            .cornerRadius(80)
                            .offset(y: 10) // Adjusted the offset
                    }
                    .sheet(isPresented: $isInvationsListsTapped, content: {
                       acceptInvation(currentUser: currentUser )
                    })
                             
                         
                    
                }
            }
        }
    }

    func checkAndUpload() {
        if senderUserName.isEmpty || accepterUserName.isEmpty {
            errorMessageUserName = "املئ جميع الحقول !"
        } else {
            errorMessageUserName = nil
        }

        if errorMessageUserName == nil {
            let newInvation = Invation(invationKey: UUID(), senderLionKey: senderUserName, isAccepted: "false", accepterCatID: accepterUserName)

            uploadInvations(invation: newInvation)
            currentUser = newInvation.senderLionKey
        }
    }

    func uploadInvations(invation: Invation) {
        let senderQuery = playersRef
            .queryOrdered(byChild: "userName")
            .queryEqual(toValue: "\(invation.senderLionKey)")

        let accepterQuery = playersRef
            .queryOrdered(byChild: "userName")
            .queryEqual(toValue: "\(invation.accepterCatID)")

        senderQuery.observeSingleEvent(of: .value) { senderSnapshot in
            accepterQuery.observeSingleEvent(of: .value) { accepterSnapshot in
                if senderSnapshot.exists() && accepterSnapshot.exists() {
                    let invitationKeyString = invation.invationKey.uuidString
                    self.ref.child(invitationKeyString).setValue([
                        "invationKey": invitationKeyString,
                        "senderLionKey": invation.senderLionKey,
                        "accepterCatID": invation.accepterCatID,
                        "isAccepted": invation.isAccepted
                    ])
                } else {
                    // Players with the specified lionKey and catID do not exist
                    print("Players not found. Invitation not uploaded.")
                    self.errorMessage = "لا يوجد مستخدم بهذا الاسم ادخل اسم مستخدم صيحي !"
                }
            }
        }
    }
}

struct sendInvation_Previews: PreviewProvider {
    static var previews: some View {
        sendInvation()
    }
}

