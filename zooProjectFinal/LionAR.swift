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
struct ARView: UIViewRepresentable {
    @StateObject var locationManager = LocationManagerAR()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var targetLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)

    func makeUIView(context: Context) -> some UIView {
        let sceneView = ARSCNView()
        sceneView.showsStatistics = true
        sceneView.scene.background.contents = UIColor.clear

        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
       


        sceneView.delegate = context.coordinator // Set the delegate

        locationManager.startUpdatingLocation { location in
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
            }
        }

        return sceneView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let userLocation = userLocation, let arSceneView = uiView as? ARSCNView else { return }

        print("User Location: \(userLocation)")
        print("Target Location: \(targetLocation)")

        let lineNode = createLineNode(from: userLocation, to: targetLocation, scale: 0.005)
        arSceneView.scene.rootNode.addChildNode(lineNode)
    }

    private func createLineNode(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D,scale: Float) -> SCNNode {
        let startVector = SCNVector3(start.longitude, start.latitude, -1.0) // Adjusted Z-coordinate
        let endVector = SCNVector3(end.longitude, end.latitude, -1.0) // Adjusted Z-coordinate

        let lineGeometry = SCNGeometry.lineFrom(vertices: [startVector, endVector])
        let lineNode = SCNNode(geometry: lineGeometry)
        
        lineNode.scale = SCNVector3(0.001,0.001, 0.001)


        return lineNode
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARView

        init(_ parent: ARView) {
            self.parent = parent
        }

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            // Additional updates, if needed
        }
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
                            .font(.system(size: 20, weight: .bold))
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

extension SCNGeometry {
    static func lineFrom(vertices: [SCNVector3]) -> SCNGeometry {
        let source = SCNGeometrySource(vertices: vertices)
        var indices: [Int32] = []
        for i in 0..<vertices.count {
            indices.append(Int32(i))
        }

        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
}

