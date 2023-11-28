//
//  loginScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI
import Firebase
import FirebaseCore


struct loginScreen: View {
    @State private var isEditing: Bool = false
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var errorMessageUserName: String?
    @State private var errorMessagePassword: String?
    
    
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                ZStack {
                    Circle()
                        .foregroundColor(Color("Color5"))
                        .blur(radius: 100)
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
                
                Text("تسجيل الدخول ")
                    .foregroundColor(Color("Color2"))
                    .font(
                        Font.custom("Poppins", size: 30
                                   )
                        .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(alignment: .top)
                    .padding(.bottom, 500)
                
                
            }
            VStack{
                TextField("اسم المستخدم", text: $userName)
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 20)
                    .foregroundColor(isEditing ? Color("Color2") : Color("Color1"))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Color1"), lineWidth: 2)
                            .frame(width: 350, height: 40)
                    )
                
                    .onChange(of: userName) { newValue in
                        if newValue.isEmpty {
                            isEditing = false
                        } else {
                            isEditing = true
                        }
                    }
                //error message place
                Text(errorMessageUserName ?? "")
                    .foregroundColor(.red)
                    .font(
                        Font.custom("Poppins", size: 12
                                   )
                        .weight(.bold)
                    )
                //
                TextField("كلمة السر ", text: $password)
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 20)
                    .foregroundColor(isEditing ? Color("Color2") : Color("Color1"))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Color1"), lineWidth: 2)
                            .frame(width: 350, height: 40)
                    )
                
                    .onChange(of: password) { newValue in
                        if newValue.isEmpty {
                            isEditing = false
                        } else {
                            isEditing = true
                        }
                    }
                Text(errorMessagePassword ?? "")
                    .foregroundColor(.red)
                    .font(
                        Font.custom("Poppins", size: 12
                                   )
                        .weight(.bold)
                    )
                    .padding(.bottom,5)
                //
                
                
            }
            VStack{
                Button(action: {
                    print("تم النقر على الزر!")
                    checkAndLogin(userName: userName, password: password)
                }) {
                    
                    
                    Text("تسجيل الدخول ")
                        .frame(width: 200, height: 15)
                        .fontWeight(.bold)
                        .foregroundColor(Color("BackgroundColor"))
                        .padding()
                        .background(Color("Color2"))
                        .cornerRadius(80)
                        .position(x:190, y: 585)
                    
                    
                }
                HStack {
                    
                    NavigationLink(destination: signUpScreen()) {
                        Text("تسجيل جديد ")
                            .foregroundColor(Color("Color2"))
                            .font(.custom("Poppins", size: 14))
                            .padding(.trailing, -4)
                        
                        
                    }
                    Text("ليس لديك حساب مسبقاً؟")
                        .font(.custom("Poppins", size: 14))
                        .foregroundColor(Color("Color1"))
                    
                }  .position(x:190, y: 250)
                
                
            }
        }
    }
        
    
    func checkAndLogin(userName:String , password:String){
        if(userName.isEmpty){
            errorMessageUserName="! اسم المستخدم مطلوب"
        }else{
            errorMessageUserName = nil
        }
        if(password.isEmpty){
            errorMessagePassword="كلمة السر مطلوبة للدخول !"
        }else{
            errorMessagePassword=nil
        }
        if errorMessagePassword == nil,errorMessageUserName == nil {
            loginWithUsername(username: userName, password:password)
            
        }
        
    }
    func loginWithUsername(username: String, password: String) {
        // Construct the email address from the username
        let userAuth = "\(username)@example.com"
        Auth.auth().signIn(withEmail: userAuth, password: password){
            authResult,error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                // Handle login error
            } else {
                // Successfully signed in
                errorMessagePassword = "true"
               
            }
        }
    }
}
 
#Preview {
    loginScreen()
}
