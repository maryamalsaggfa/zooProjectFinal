import SwiftUI

struct introRegisteration: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    
                    Text("واقع الأدغال")
                        .foregroundColor(Color("Color2"))
                        .font(
                            Font.custom("Poppins", size: 20
                                       )
                            .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .frame(alignment: .top)
                    Spacer().frame(height: 21)
                    
                    Text("عندما يمسك الأسد القطة، تنقلب الموازين! هل يمكن للقطة التفاف خطير على الأسد والهروب بسرعة، أم سيتمكن الأسد من افترس فريسته؟\n")
                        .font(Font.custom("Poppins", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Color1"))
                        .frame(width: 330, height: 80, alignment: .top)
                    
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
                    }) {
                        NavigationLink(destination: signUpScreen()) {
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
                VStack{
                    Spacer()
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
                    }
                    
                }                     .padding(.bottom, 120)

            }
        }
    }}
            
            #Preview {
                introRegisteration()
            }
            
        
