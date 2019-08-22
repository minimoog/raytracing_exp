//
//  Ray.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 8/22/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import simd

struct Ray {
    var origin: float3
    var direction: float3
    
    func pointAtParameter(t: Float) -> float3 {
        return origin + t * direction
    }
}
