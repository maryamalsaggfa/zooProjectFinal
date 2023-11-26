//
//  permissionScreen.swift
//  zooProjectFinal
//
//  Created by maryam on 12/05/1445 AH.
//

import SwiftUI
import CoreLocation
import AVFoundation
class CameraPermission: ObservableObject {
    
    @Published var isCameraPermission:Bool = false
    
    func getCameraPermission() async {
        
        let status =  AVCaptureDevice.authorizationStatus(for: .video)
        
        switch(status){
        case .authorized:
            isCameraPermission = true
        case .notDetermined:
            await AVCaptureDevice.requestAccess(for: .video)
            isCameraPermission = true
        case .denied:
            isCameraPermission = false
        case .restricted:
            isCameraPermission = false
            
            
        @unknown default:
            isCameraPermission = false
        }
        
    }
    
}
class LocationPermission:NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    private let locationManager = CLLocationManager()
    @Published var cordinates : CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestLocationPermission()  {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        cordinates = location.coordinate
    }
    
    
}
struct permissionScreen: View {
    @StateObject private var cameraPermission:CameraPermission=CameraPermission()

    @StateObject private var locationPermission:LocationPermission=LocationPermission()
    
    var body: some View {
        VStack{
            Text("Camera Permission \(cameraPermission.isCameraPermission.description)")

            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            switch locationPermission.authorizationStatus{
                
            case .notDetermined:
                Text("not determied")
            case .restricted:
                Text("restricted")
            case .denied:
                Text("denied")
            case .authorizedAlways:
                VStack {
                    Text(locationPermission.cordinates?.latitude.description ?? "")
                    Text(locationPermission.cordinates?.longitude.description ?? "")
                    
                }
                
            case .authorizedWhenInUse:
                VStack {
                    Text(locationPermission.cordinates?.latitude.description ?? "")
                    Text(locationPermission.cordinates?.longitude.description ?? "")
                    
                }
                
                
            default:
                Text("no")
            }
            Button {
                locationPermission.requestLocationPermission()
            } label: {
                Text("Ask Location Permission")
                    .padding()
            }
            Button {
                        Task{
                            await  cameraPermission.getCameraPermission()
                        }
                    } label: {
                        Text("Ask Camera Permission")
                            .padding()
                    }
            
            
        
        }
        
    }
}

#Preview {
    permissionScreen()
}
