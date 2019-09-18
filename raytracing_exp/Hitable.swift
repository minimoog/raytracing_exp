//
//  hitable.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 9/18/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import Foundation
import simd

struct HitRecord {
    let t: Float
    let p: float3
    let normal: float3
}

protocol Hitable {
    func hit(r: Ray, tmin: Float, tmax: Float) -> HitRecord?
}
