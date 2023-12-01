//
//  acceptInvation.swift
//  zooProjectFinal
//
//  Created by maryam on 15/05/1445 AH.
//

import SwiftUI
import Firebase
import FirebaseDatabase
class invationViewList:ObservableObject{
    
    @Published var invations:[invations]=[]
    
    init() {
            //fetchData()
        }
}

func fetchingUserInvations(){
    
    
}
struct acceptInvation: View {
    
    @State var currentUser = ""
    
    var body: some View {
        Text("\(currentUser)")
        
    }
}


#Preview {
    acceptInvation()
}
