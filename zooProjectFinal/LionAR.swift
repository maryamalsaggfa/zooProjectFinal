//// LionAR.swift
// zooProjectFinal
//
// Created by maryam on 15/05/1445 AH.

import SwiftUI
import ARKit
import CoreLocation

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

struct ARView: UIViewRepresentable {
    
    @StateObject var countdownViewModel = CountdownViewModel()
    
    func makeUIView(context: Context) -> some UIView {
        let sceneView = ARSCNView()
        sceneView.showsStatistics = true
        
        if let scene = SCNScene(named: "dog.obj") {
            // Unwrap the optional scene
            sceneView.scene = scene
            
            // Access the root node of the scene
            if let rootNode = scene.rootNode.childNode(withName: "dog", recursively: true) {
                // Scale the root node
                let scale: Float = 0.001 // Adjust the scale factor as needed
                rootNode.scale = SCNVector3(scale, scale, scale)
            } else {
                print("Error: Unable to find the root node (dog) in the scene")
            }
        } else {
            print("Error: Unable to load dog.obj scene")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
        return sceneView
    }
    
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
    
    class LocationManagerAR: NSObject, CLLocationManagerDelegate, ObservableObject {
        static let shared = LocationManagerAR()
        
        private var locationManager = CLLocationManager()
        private var locationCallback: ((CLLocation) -> Void)?
        
        public override init() {
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        func startUpdatingLocation(callback: @escaping (CLLocation) -> Void) {
            locationCallback = callback
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            locationCallback?(location)
        }
    }
    
    
    
    
    struct contentView: View {
        
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
                                .font(.custom("Ithra-Bold", size: 20))
                            
                                .padding()
                                .foregroundColor(.black)
                            
                            Text("\(countdownViewModel.counter)")
                                .font(.system(size: 100, weight: .bold))
                                .padding()
                                .foregroundColor(.black)
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
    
    struct LionAR: View {
        
        var invitionsKey:String
        
        var body: some View {
            ARView()
        }
    }
    
#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        
        @State static private var dummystringInvitionKey = ""
        static var previews: some View {
            LionAR(invitionsKey: dummystringInvitionKey)
        }
    }
#endif
    
    
    
    

