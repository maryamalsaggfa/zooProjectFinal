//
//  ARcat.swift
//  zooProjectFinal
//
//  Created by maryam on 15/05/1445 AH.
//

import SwiftUI
import ARKit

struct ARView1: UIViewRepresentable{

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
        
        
    }
struct ARcat: View {
    var body: some View {
        ARView1()
    }
}

#Preview {
    ARcat()
}
