//
//  AccountScreen.swift
//  zooProjectFinal
//
//  Created by Faizah Almalki on 18/05/1445 AH.
//

import SwiftUI
import Firebase
struct AccountScreen: View {
    @State private var isAccountScreenPresented = false
    @State private var isUserLoggedOut = false
    @State private var isMuted = false
    let audioPlayer = AudioPlayer.shared
    let userName: String
    @State private var email: String?
    @State private var password: String?
    @State private var isLoading = false
    var ref = Database.database().reference()
    
    // fetch the data of the user and show it uo in the fileds
    //let the user logout and by going to first page
    var body: some View{
        ZStack{
            
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            
            if isLoading{
                ProgressView()
            }else {
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .onTapGesture {
                        isMuted.toggle()
                        audioPlayer.toggleMute(isMuted: isMuted)
                    }
                    .font(.system(size: 25))
                    .foregroundColor(Color("Color2"))
                    .offset(x: 150)
                    .offset(y: -360)
                
                
                
                
                
                HStack{
                    Button(action: { isAccountScreenPresented=true
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 25))
                        
                            .foregroundColor(Color("Color2"))
                    }   .fullScreenCover(isPresented: $isAccountScreenPresented)
                    {
                        sendInvation(userName:userName)
                    }                              .offset(x:-120)
                    
                    
                    
                    
                    Text("الحساب")
                        .font(
                            Font.custom("Ithra", size: 25)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Color2"))
                        .offset(x: 0)
                    
                    
                    
                    
                }
                .offset(y: -360)
                
                VStack{
                    Image("PL2")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .background(Color("Color4"))
                        .clipShape(Circle())
                    
                    Text("\(userName)")
                        .font(
                            Font.custom("Poppins", size: 20)
                                .weight(.bold)
                            
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Color2"))
                    
                }                    .offset(y: -250)
                
                
                
                VStack{
                    VStack(spacing: 0) {
                        Text("اسم المستخدم")
                            .font(
                                Font.custom("Ithra", size: 12)
                            )                    .foregroundColor(Color("Color1"))
                            .multilineTextAlignment(.center)
                            .padding(.leading, 260)
                            .padding(.top, 150)
                        
                        
                        Text("\(userName)")
                            .padding()
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color("Color1"))
                        
                            .padding(.leading,270 )
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Color1"), lineWidth: 2)
                                    .frame(width: 350, height: 40)
                            )
                        
                        
                        
                        
                        
                    }
                    VStack(spacing: 0) {
                        Text("البريد الالكتروني ")
                            .font(
                                Font.custom("Ithra", size: 12)
                            )                          .foregroundColor(Color("Color1"))
                            .multilineTextAlignment(.center)
                            .padding(.leading, 260)
                        
                        Text("ssa@gmail.com")
                            .padding()
                            .multilineTextAlignment(.trailing)
                            .padding(.leading,200 )
                            .foregroundColor(Color("Color1"))
                        
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Color1"), lineWidth: 2)
                                    .frame(width: 350, height: 40)
                            )
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    VStack(spacing: 0) {
                        Text("كلمة السر")
                            .font(
                                Font.custom("Ithra", size: 12)
                            )                      .foregroundColor(Color("Color1"))
                            .multilineTextAlignment(.center)
                            .padding(.leading, 260)
                        
                        Text("*********")
                            .padding()
                            .multilineTextAlignment(.trailing)
                            .padding(.leading,200 )
                            .foregroundColor(Color("Color1"))
                        
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Color1"), lineWidth: 2)
                                    .frame(width: 350, height: 40)
                            )
                        
                        
                        
                        
                        
                    }
                    
                    
                } .offset(y: -100)
                
                
                Button(action: {
                    isUserLoggedOut = true
                }) {
                    Text("تسجيل الخروج")
                        .font(Font.custom("Poppins", size: 15).weight(.bold))
                        .foregroundColor(Color(red: 1, green: 0.26, blue: 0.06))
                        .frame(width: 105, height: 18, alignment: .top)
                        .padding()
                }
                .fullScreenCover(isPresented: $isUserLoggedOut)
                {
                    introRegisteration()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(red: 0.07, green: 0.12, blue: 0.08))
                        .frame(width: 326, height: 42)
                )
                .offset(y: 320)
                
                
                
                
            }
            
            
        }
    }
    func fetchUserData(userName:String){
        ref.child("Players").child(userName).observeSingleEvent(of: .value){ snapshot in
            guard let data = snapshot.value as? [String: Any],let email = data["email"] as? String,let password = data["password"] as? String else {
                print("can't load error")
                return
            }
            
        }
    }
}

    


#Preview {
    AccountScreen(userName:"")
}
