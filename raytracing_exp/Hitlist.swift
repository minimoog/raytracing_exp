//
//  Hitlist.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 9/18/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import Foundation
import simd

extension Array: Hitable where Element: Hitable {
    func hit(r: Ray, tmin: Float, tmax: Float) -> HitRecord? {
        var returnRec: HitRecord?
        var closestSoFar = tmax
        
        for element in self {
            if let hitRecord = element.hit(r: r, tmin: tmin, tmax: closestSoFar) {
                closestSoFar = hitRecord.t
                returnRec = hitRecord
            }
        }
       
        return returnRec
    }
    
    func getColor(ray: Ray) -> float3 {
        if let hitRecord = self.hit(r: ray, tmin: 0.0, tmax: Float.greatestFiniteMagnitude) {
            return 0.5 * float3(hitRecord.normal.x + 1.0, hitRecord.normal.y + 1.0, hitRecord.normal.z + 1.0)
        } else {
            let unitDirection = normalize(ray.direction)
            let t = 0.5 * (unitDirection.y + 1.0)
        
            return (1.0 - t) * float3(1.0, 1.0, 1.0) + t * float3(0.5, 0.7, 1.0)
        }
    }
}
