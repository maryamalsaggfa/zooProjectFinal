//
//  signUpScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase




struct signUpScreen: View {
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessageUserName: String?
    @State private var errorMessageEmail: String?
    @State private var errorMessagePassword: String?
    @State private var errorMessageConfirmPassword: String?
    let ref = Database.database().reference().child("Players")

    
    var body: some View {
        ZStack{
        Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150 , height: 150)
                Spacer(minLength: 90)
                Text("تسجيل جديد")
                    .foregroundColor(Color("Color2"))
                    .font(
                        Font.custom("Poppins", size: 20
                                   )
                        .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(alignment: .top)
                    .padding(.bottom, 10)
                VStack{
                   
                    TextField("اسم المستخدم", text: $userName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    //error message place
                    Text(errorMessageUserName ?? "")
                                  .foregroundColor(.red)
                                  .font(
                                      Font.custom("Poppins", size: 12
                                                 )
                                      .weight(.bold)
                                  )
                    //
                    TextField("الايميل", text: $email)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    //error message place
                    Text(errorMessageEmail ?? "")
                                  .foregroundColor(.red)
                                  .font(
                                      Font.custom("Poppins", size: 12
                                                )
                                      .weight(.bold)
                                  )
                    //
                    
                    TextField("كلمة السر ", text: $password)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(errorMessagePassword ?? "")
                                  .foregroundColor(.red)
                                  .font(
                                      Font.custom("Poppins", size: 12
                                                 )
                                      .weight(.bold)
                                  )
                    //
                    TextField("تأكيد كلمة السر ", text: $confirmPassword)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(errorMessageConfirmPassword ?? "")
                                  .foregroundColor(.red)
                                  .font(
                                      Font.custom("Poppins", size: 12
                                                 )
                                      .weight(.bold)
                                  )
                                  .padding(.bottom,5)
                    //
                    
                }
                Button(action: {
                   checkAndUploadData()

                }) {
                    NavigationLink(destination: loginScreen()) {
                        Text("تسجيل")
                            .frame(width: 200, height: 15)
                            .fontWeight(.bold)
                            .foregroundColor(Color("BackgroundColor"))
                            .padding()
                            .background(Color("Color2"))
                            .cornerRadius(80)
                    }
                }
                .padding(.bottom, 150)
            }
           
        
    }
       
        }
    func checkAndUploadData(){
        if userName.isEmpty{
            errorMessageUserName = "قم بتعبئة اسم المستخدم !"
                   } else {
                       errorMessageUserName = nil
                   }
        if email.isEmpty{
            errorMessageEmail="قم بتعبئة الايميل !"
        }else if !isValidEmail(email) {
            errorMessageEmail = "الرجاء إدخال ايميل صحيح"
        }
        else {
            errorMessageEmail=nil
        }
        if password.isEmpty{
            errorMessagePassword="قم بتعبئة كلمة السر"
        }else if password.count < 8{
            errorMessagePassword = "يجب أن تكون كلمة السر مؤلفة من 8 أحرف"
        }
        else{
            errorMessagePassword=nil
        }
        if(confirmPassword.isEmpty){
            errorMessageConfirmPassword="قم بتعبئة تأكيد كلمة السر !"
        }else if !(confirmPassword==password){
            errorMessageConfirmPassword="يجب ان تكون تأكيد كلمة السر مطابقاً لكلمة السر"
        }else{
            errorMessageConfirmPassword=nil
        }
        
        if errorMessageUserName == nil,
               errorMessageEmail == nil,
               errorMessagePassword == nil,
           errorMessageConfirmPassword == nil {
            
            let newUser = Players(userName: userName, email: email, confirmPassWord: confirmPassword, password: password)
            uploadToDatabase(Players: newUser)
        }
        
        }
    func uploadToDatabase(Players:Players) {
        ref.queryOrdered(byChild: "userName").queryEqual(toValue: userName).observeSingleEvent(of: .value){ snapshot in
            if (snapshot.exists()){
                errorMessageUserName = "اسم المستخدم مستخدم بالفعل"
                
            }else{
                ref.child("Players").child(Players.userName).setValue([
                    "userName": Players.userName,
                    "email": Players.email,
                    "password": Players.password,
                    "confirmPassWord":Players.confirmPassWord
                    // Add other properties as needed
                ]){ error, _ in
                    if let error = error {
                        print("خطأ في التسجيل: \(error.localizedDescription)")
                    } else {
                      //move to other page
                        
                      
                    }
                }

                // Clear the error message (if any)
                errorMessageUserName = nil
                
            }
            
        }
  
    }
    
    }






func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}


#Preview {
    signUpScreen()
}
