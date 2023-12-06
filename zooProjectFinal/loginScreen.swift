//
//  loginScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI
import Firebase
import FirebaseCore

class UserManager: ObservableObject {
    @Published var currentUser: currentUserNow?
    let ref = Database.database().reference().child("Players")
    
    func login(username: String, password: String) {
       //print("mmm")
        ref.child(username).observeSingleEvent(of: .value){
            [weak self] snapshot,error in
            guard self != nil else {
                print("Self is nil.")
                return
            }
            if let error=error{
                print("\(error)")
            }
            
            guard let strongSelf = self else { return }
            
            guard snapshot.exists(), let userData = snapshot.value as? [String: Any], let storedPassword = userData["password"] as? String else {
                         print("User data not found or password missing.")
                         return
                     }

                     if password == storedPassword {
                         print("Login successful")
                         let currentUser = currentUserNow(userNmae: username, password: password)
                         strongSelf.currentUser = currentUser
                     } else {
                         print("Incorrect password")
                     }
            
            
        }
    }
        
        func logout() {
            currentUser = nil
        }
    }


struct loginScreen: View {
    @State private var isEditing: Bool = false
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var errorMessageUserName: String?
    @State private var errorMessagePassword: String?
    @State public var user=""
    @State private var isLoggedIn = false
    
    @State private var isSignUpScreenPresented = false
    @State private var isAccountScreenPresented = false
    
    @StateObject private var userManager = UserManager()
    @State private var isPasswordVisible = false
    

    
    var body: some View {
        VStack{
            ZStack{
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                ZStack {
                    Circle()
                        .foregroundColor(Color("Color5"))
                        .blur(radius: 100)
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(y: -250)
                    
                }
                
                Button(action: { isAccountScreenPresented=true
                  }) {
                                   Image(systemName: "x.circle")
                                       .font(.system(size: 25))
                                       .foregroundColor(Color("Color2"))
                                }   .fullScreenCover(isPresented: $isAccountScreenPresented) {
                                    introRegisteration()
                                }
                                .position(x:350,y:30)
                
                Text("تسجيل الدخول ")
                    .foregroundColor(Color("Color2"))
                    .font(.custom("Ithra-Bold", size: 25))
                    .multilineTextAlignment(.center)
                    .frame(alignment: .top)
                    .offset(y : -150)
                
                VStack (spacing: 0) {
                    
              
                    
                    
                    Text("اسم المستخدم").foregroundColor( Color("Color1")) .padding(.leading,250)
                    TextField(" اسم المستخدم", text: $userName)
                        .padding()
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 20)
                    
                        .foregroundColor( Color("Color2"))
                        .font(.custom("Ithra-light", size: 14))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Color1"), lineWidth: 2)
                                .frame(width: 350, height: 40)
                            
                        )
                    
                    
                    //error message place
                    Text(errorMessageUserName ?? "")
                        .foregroundColor(.red)
                        .font(.custom("Ithra-light", size: 10))
                    
                    //
                    Text("كلمة السر").foregroundColor( Color("Color1")) .padding(.leading,250)
                    HStack {
                     
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(Color("Color1"))
                                
                        }
                        .padding(.leading,30)
                        if isPasswordVisible {
                               TextField("كلمة السر", text: $password)
                           } else {
                               SecureField("كلمة السر", text: $password)
                           }
                    }
                    .padding()
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 20)
                    .foregroundColor(Color("Color2"))
                    .font(.custom("Ithra-light", size: 14))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Color1"), lineWidth: 2)
                            .frame(width: 350, height: 40)
                    )
                      
                    Text(errorMessagePassword ?? "")
                        .foregroundColor(.red)
                        .font(.custom("Ithra-light", size: 10))
                    //
                    
                    
                }.offset(y : 20)
                
                VStack{
                    Button(action: {
                       
                        checkAndLogin(userName: userName, password: password)
                    }) {
                        Text("تسجيل الدخول ")
                            .frame(width: 200, height: 15)
                            .font(.custom("Ithra-Bold", size: 16))
                        
                            .fontWeight(.bold)
                            .foregroundColor(Color("BackgroundColor"))
                            .padding()
                            .background(Color("Color2"))
                            .cornerRadius(80)
         
                    }
                    .position(x:190, y: 585)
    
                    HStack {
                        Button(action: {
                            // Present the signUpScreen when the button is clicked
                            isSignUpScreenPresented=true
                        }) {
                            Text("تسجيل جديد ")
                                .font(.custom("Ithra-light", size: 14))
                                .foregroundColor(Color("Color2"))
                                .font(.custom("Poppins", size: 14))
                                .padding(.trailing, -4)
                        }
                        .fullScreenCover(isPresented: $isSignUpScreenPresented) {
                            // Your signUpScreen view
                            signUpScreen()
                        }
                        
                        Text("ليس لديك حساب مسبقاً؟")
                            .font(.custom("Ithra-light", size: 14))
                            .font(.custom("Poppins", size: 14))
                            .foregroundColor(Color("Color1"))
                    }
                    .position(x: 190, y: 250)
                    .fullScreenCover(isPresented: $isLoggedIn) {
                        // Your signUpScreen view
                        sendInvation(InvationKey:"", userName:user)
                    }
                    
                    
                }
            }.navigationBarBackButtonHidden(true)
            .onReceive(userManager.$currentUser) { currentUser in
                // Step 5: React to changes, e.g., navigate to another screen
                if let _ = currentUser {
                    print("User logged in")
                    user = currentUser?.userNmae ?? ""
                    isLoggedIn = true
                    // Navigate to another screen or perform other actions
                }
            }
        }
        .ignoresSafeArea(.keyboard)
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
            userManager.login(username:userName, password: password)
            
            
        }
        
    }
    func loginWithUsername(username: String, password: String) {
    
    }
}
 
#Preview {
    loginScreen()
}
