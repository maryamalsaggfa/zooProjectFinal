//
//  signUpScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI

struct signUpScreen: View {
    var body: some View { ZStack{
        Color("BackgroundColor").edgesIgnoringSafeArea(.all)
        VStack{
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width:150 , height: 150)
            Spacer(minLength: 520)
            
        }
        
    }
    }
}

#Preview {
    signUpScreen()
}
