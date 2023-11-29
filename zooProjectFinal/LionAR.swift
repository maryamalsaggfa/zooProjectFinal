//
//  LionAR.swift
//  zooProjectFinal
//
//  Created by maryam on 15/05/1445 AH.
//

import SwiftUI
import ARKit
class CountdownViewModel: ObservableObject {
    @Published var counter = 5
    
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.counter > 0 {
                print("Counter: \(self.counter)")
                self.counter -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}
struct ARView: UIViewRepresentable{

    func makeUIView(context: Context)->some UIView{
        let sceneView = ARSCNView()
        sceneView.showsStatistics = true
        //let scene = SCNScene(named: "34-cat3d")
        //let scene = optionalScene ?? defaultScene
        //scene = SCNScene(named: "34-cat3d")
        //sceneView.scene = scene
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        return sceneView
    
        
}
    func updateUIView(_ uiView: UIViewType, context: Context) {}
        
        
    struct ContentView: View {
        @StateObject var countdownViewModel = CountdownViewModel()
        @State private var showCounter = true
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    ARView()
                        .edgesIgnoringSafeArea(.all)
                    
                    if showCounter {
                        VStack {
                            
                                Text("استعد سوف تبدأ اللعبه خلال :")
                                    .font(.system(size: 20, weight: .bold))
                                    .padding()
                                    .foregroundColor(.black)
                                    .onReceive(countdownViewModel.$counter) { counter in
                                        if counter == 0 {
                                            withAnimation {
                                                showCounter = false
                                            }
                                        }
                                    }
                            
                            Text(" \(countdownViewModel.counter)")
                                .font(.system(size: 100, weight: .bold))
                                .padding()
                                .foregroundColor(.black)
                                .onReceive(countdownViewModel.$counter) { counter in
                                    if counter == 0 {
                                        withAnimation {
                                            showCounter = false
                                        }
                                    }
                                }
                           
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
            }
            .onAppear {
                countdownViewModel.startCountdown()
            }
        }
    }
  }

struct LionAR: View {
    var body: some View {
        ARView()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LionAR()
    }
}
#endif
