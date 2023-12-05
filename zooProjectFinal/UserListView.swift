//
//  UserListView.swift
//  zooProjectFinal
//
//  Created by maryam on 20/05/1445 AH.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = invationViewList()

   
        var body: some View {
            Text("hello world")
            List(viewModel.userInvationss){ invation in 
                Text("user Name :\(invation.senderLionKey)")
                
                
            }
            
           }
        
    
}

#Preview {
    UserListView()
}
