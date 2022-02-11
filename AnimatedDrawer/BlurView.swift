//
//  BlurView.swift
//  AnimatedDrawer
//
//  Created by shehan karunarathna on 2022-02-11.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    var style:UIBlurEffect.Style
    func makeUIView(context: Context) ->  UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
    
}


