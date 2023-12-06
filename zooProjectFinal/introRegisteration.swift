import SwiftUI

struct introRegisteration: View {
    @State private var isScreenPresented = false
    @State private var isScreenPresentedRegister = false

    var body: some View {
        
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    
                    Text("واقع الأدغال")
                        .foregroundColor(Color("Color2"))
                        .font(
                            Font.custom("Ithra-Bold", size: 20)
                            .weight(.bold)
                            
                        )
                        .offset(y: -20)
                        .multilineTextAlignment(.center)
                        .frame(alignment: .top)
                    Spacer().frame(height: 21)
                        .offset(y: 10)
                    
                    Text("تأخذك هذه اللعبة في رحلة مثيرة إلى عالم مليء بالتوتر والإثارة.\n في كل جولة، ستجد نفسك في دور الفريسة أو المفترس، حيث تتبادل الأدوار بين الطرفين بين البحث الحماسي عن الفريسة والاختباء الذكي لتفادي المفترس. ")
                        .offset(y: -20)
                        .font(Font.custom("Ithra-Light", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Color1"))
                        .frame(width:380, alignment: .top)
                    
                }
                
                .offset(y: -60)
                HStack {
                    Spacer()
                    Image("Lion")                          .resizable()
                        .frame(width: 202, height: 133)
                    
                    Spacer()
                    Image("Cat")
                        .frame(width: 114, height: 54)
                        .opacity(0.7)
                    
                    Spacer()
                }.offset(y: 60)
                VStack {
                    Spacer()
                    Button(action: {
                        // الاكشن المرتبط بالزر هنا
                        isScreenPresentedRegister = true
                    })
                  //  signUpScreen()
                    
                    {
                        
                        
                       
                            Text("تسجيل")
                                .frame(width: 200, height: 15)
                                .font(.custom("Ithra-Bold", size: 16))

                                .fontWeight(.bold)
                                .foregroundColor(Color("BackgroundColor"))
                                .padding()
                                .background(Color("Color2"))
                                .cornerRadius(80)
                                .position(x:190, y: 585)
                        
                    }.fullScreenCover(isPresented: $isScreenPresentedRegister) {
                        signUpScreen()
                    }
                   
                    
                }
                VStack{
                    Spacer()
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
                                .font(.custom("Ithra-Light", size: 14))
                            .foregroundColor(Color("Color1"))
                    }
                        .position(x:190, y: 630)
                    
                }

            }
        }
    }
            
            #Preview {
                introRegisteration()
            }
            
        
