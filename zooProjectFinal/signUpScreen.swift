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

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    @Published var currentLocation: CLLocation?

    override init() {
        super.init()
        setupLocationManager()
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
        }
    }
}

struct signUpScreen: View {
    
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var curentLocation: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessageUserName: String?
    @State private var errorMessageEmail: String?
    @State private var errorMessagePassword: String?
    @State private var errorMessageConfirmPassword: String?
    @State private var isScreenPresented = false
    
    @State private var isAccountScreenPresented = false
    
    @State private var isAccountScreenRegiterd = false
    
    @State private var isPasswordVisible = false
    @State private var isPasswordVisibleConferm = false

    
    @ObservedObject private var locationManager = LocationManager()
    
    let ref = Database.database().reference().child("Players")

    
    var body: some View {
      //  ScrollView {
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
                    
                }.offset(y: -290)
                VStack{
                    
                    
                    
                    
                    Button(action: { isAccountScreenPresented=true
                    }) {
                        Image(systemName: "x.circle")
                            .font(.system(size: 25))
                            .foregroundColor(Color("Color2"))
                    }   .fullScreenCover(isPresented: $isAccountScreenPresented) {
                        introRegisteration()
                    }
                    .position(x:350,y:20)
                    Text("تسجيل جديد")
                        .foregroundColor(Color("Color2"))
                        .font(.custom("Ithra-Bold", size: 25))
                        .multilineTextAlignment(.center)
                        .frame(alignment: .top)
                        .offset(y:-150)
                    
                    VStack(spacing: 0){
                        Text("اسم المستخدم").foregroundColor( Color("Color1")) .padding(.leading,250)
                        TextField("اسم المستخدم", text: $userName)
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
                        Text("البريد الإلكتروني").foregroundColor( Color("Color1")) .padding(.leading,250)
                        //
                        TextField("البريد الإلكتروني", text: $email)
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
                        Text(errorMessageEmail ?? "")
                            .foregroundColor(.red)
                            .font(.custom("Ithra-light", size: 10))
                        
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
                        Text("تأكيد كلمة السر ").foregroundColor( Color("Color1")) .padding(.leading,250)
                        HStack {
                         
                            Button(action: {
                                isPasswordVisibleConferm.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(Color("Color1"))
                                    
                            }
                            .padding(.leading,30)
                            if isPasswordVisibleConferm {
                                   TextField("كلمة السر", text: $confirmPassword)
                               } else {
                                   SecureField("كلمة السر", text: $confirmPassword)
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
                        
                        
                        Text(errorMessageConfirmPassword ?? "")
                            .foregroundColor(.red)
                            .font(.custom("Ithra-light", size: 10))
                        
                        //
                        
                    }.offset(y:-140)
                    
                    Button(action: {
                        checkAndUploadData()
                        
                    }) {
                        Text("تسجيل")
                            .frame(width: 200, height: 15)
                            .font(.custom("Ithra-light", size: 16))
                        
                            .fontWeight(.bold)
                            .foregroundColor(Color("BackgroundColor"))
                            .padding()
                            .background(Color("Color2"))
                            .cornerRadius(80)
                        
                    }
                    .offset(y :-100)
                    .fullScreenCover(isPresented: $isAccountScreenRegiterd) {
                        loginScreen()
                    }
                    
                }
                HStack {
                    
                    Button(action: {
                        isScreenPresented=true
                    }) {
                        Text("تسجيل دخول ")
                            .font(.custom("Ithra-light", size: 14))
                            .foregroundColor(Color("Color2"))
                            .font(.custom("Poppins", size: 14))
                            .padding(.trailing, -4)
                    }
                    .fullScreenCover(isPresented: $isScreenPresented) {
                        loginScreen()
                    }
                    
                    
                    
                    
                    Text("هل لديك حساب مسبقاً؟")
                        .font(.custom("Ithra-light", size: 14))
                        .foregroundColor(Color("Color1"))
                    
                } .offset(y :300)
                
                
            }
            .ignoresSafeArea(.keyboard)
            
        }
        
    
        
        
    func checkAndUploadData(){
        if userName.isEmpty{
            errorMessageUserName = "قم بتعبئة اسم المستخدم !"
                   } else {
                       errorMessageUserName = nil
                   }
        if email.isEmpty{
            errorMessageEmail="قم بتعبئة البريد الإلكتروني !"
        }else if !isValidEmail(email) {
            errorMessageEmail = "الرجاء إدخال بريد إلكتروني صحيح"
        }
        else {
            errorMessageEmail=nil
        }
        if password.isEmpty{
            errorMessagePassword="قم بتعبئة كلمة السر"
        }else if password.count < 8{
            errorMessagePassword = "يجب أن تكون كلمة السر مؤلفة من 8أحرف او ارقام"
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
            
            let newUser = Players(userName: userName, email: email, confirmPassWord: confirmPassword, password: password,latitude: "",longitude: "")
            
            uploadToDatabase(Players: newUser)
        }
        
        }
    func uploadToDatabase(Players:Players) {
        let latitude = locationManager.currentLocation?.coordinate.latitude ?? 0.0
                      let longitude = locationManager.currentLocation?.coordinate.longitude ?? 0.0

        ref.queryOrdered(byChild: "userName").queryEqual(toValue: userName).observeSingleEvent(of: .value){ snapshot in
            if (snapshot.exists()){
                errorMessageUserName = "اسم المستخدم مستخدم بالفعل"
                
            }else{
                ref.child(Players.userName).setValue([
                    "userName": Players.userName,
                    "email": Players.email,
                    "password": Players.password,
                    "confirmPassWord":Players.confirmPassWord,
                    "latitude": latitude,
                    "longitude": longitude
                   
                    // Add other properties as needed
                ]){ error, _ in
                    if let error = error {
                        print("خطأ في التسجيل: \(error.localizedDescription)")
                    } else {
                      //move to other page
                        
                        isAccountScreenRegiterd = true

                      
                        
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

