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
    @State private var isEditing: Bool = false
    
    let ref = Database.database().reference().child("Players")
    
    
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
                
                Text("تسجيل جديد")
                    .foregroundColor(Color("Color2"))
                    .font(
                        Font.custom("Poppins", size: 30
                                   )
                        .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(alignment: .top)
                    .padding(.bottom, 10)
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
                    TextField("الايميل", text: $email)
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
            HStack {
                
                NavigationLink(destination: loginScreen()) {
                    Text("تسجيل الدخول")
                        .foregroundColor(Color("Color2"))
                        .font(.custom("Poppins", size: 14))
                        .padding(.trailing, -4)
                    
                    
                }
                Text("هل لديك حساب مسبقاً؟")
                    .font(.custom("Poppins", size: 14))
                    .foregroundColor(Color("Color1"))
                
            }  .position(x:200, y: 630)
            
            
            
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
            uploadToDatabase(players: newUser)
        }
        
    }
    func uploadToDatabase(players: Players) {
        // Step 1: Create user with email and password
        Auth.auth().createUser(withEmail: "\(players.userName)@example.com", password: players.password) { authResult, error in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                errorMessageUserName = "خطأ في التسجيل: \(error.localizedDescription)"
            } else {
                // Step 2: Successfully signed up, now update the user information in the database
                guard let uid = authResult?.user.uid else {
                    print("Error getting user ID after sign up.")
                    errorMessageUserName = "حدث خطأ غير متوقع."
                    return
                }
                
                // Step 3: Check if the username already exists in the database
                ref.queryOrdered(byChild: "userName").queryEqual(toValue: players.userName).observeSingleEvent(of: .value) { snapshot in
                    if snapshot.exists() {
                        errorMessageUserName = "اسم المستخدم مستخدم بالفعل"
                    } else {
                        // Step 4: Username is not taken, update user information in the database
                        let userRef = ref.child("Players").child(uid)
                        userRef.setValue([
                            "userName": players.userName,
                            "email":players.email,
                            "password": players.password,
                            "confirmPassWord": players.confirmPassWord
                            // Add other properties as needed
                        ]) { error, _ in
                            if let error = error {
                                print("Error updating user information: \(error.localizedDescription)")
                                errorMessageUserName = "خطأ في تحديث معلومات المستخدم."
                            } else {
                                // Step 5: Move to other page or perform other actions upon successful sign up
                               
                            }
                        }
                    }
                }
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
