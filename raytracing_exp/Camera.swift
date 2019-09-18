//
//  Camera.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 9/18/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import Foundation
import simd

struct Camera {
    let origin = float3(0.0, 0.0, 0.0)
    let lowerLeftCorner = float3(-2.0, -1.0, -1.0)
    let horizontal = float3(4.0, 0.0, 0.0)
    let vertical = float3(0.0, 2.0, 0.0)
    
    func getRay(u: Float, v: Float) -> Ray {
        let uhor = u * horizontal
        let vver = v * vertical
        let dir = lowerLeftCorner + uhor + vver - origin
        
        return Ray(origin: origin, direction: dir)
    }
}
