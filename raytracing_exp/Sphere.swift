//
//  Sphere.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 9/18/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import Foundation
import simd

struct Sphere: Hitable {
    let center: float3
    let radius: Float
    
    func hit(r: Ray, tmin: Float, tmax: Float) -> HitRecord? {
        let oc = r.origin - center
        let a = dot(r.direction, r.direction)
        let b = dot(oc, r.direction)
        let c = dot(oc, oc) - radius * radius
        let discriminant = b * b -  a * c
        
        if discriminant > 0 {
            let temp = (-b - sqrt(b * b - a * c)) / a
            
            if temp < tmax && temp > tmin {
                let t = temp
                let p = r.pointAtParameter(t: t)
                let normal = (p - center) / radius
                
                return HitRecord(t: t, p: p, normal: normal)
            }
            
            let temp2 = (-b + sqrt(b * b - a * c)) / a
            
            if temp2 < tmax && temp2 > tmin {
                let t = temp2
                let p = r.pointAtParameter(t: t)
                let normal = (p - center) / radius
                
                return HitRecord(t: t, p: p, normal: normal)
            }
        }
        
        return nil
    }
}
