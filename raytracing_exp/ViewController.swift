//
//  ViewController.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 8/20/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit
import Foundation
import simd

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nx = 200
        let ny = 100
        let ns = 100
        
        let world = [Sphere(center: float3(0.0, 0.0, -1.0), radius: 0.5),
                     Sphere(center: float3(0.0, -100.5, -1.0), radius: 100)]
        
        let camera: Camera = Camera()
        
        var pixelData: [PixelData] = [PixelData]()
        
        for j in (0 ..< ny).reversed() {
            for i in 0 ..< nx {
                var color = float3(0.0, 0.0, 0.0)
                
                for _ in 0 ..< ns {
                    let u = (Float(i) + Float.random(in: 0 ..< 1)) / Float(nx)
                    let v = (Float(j) + Float.random(in: 0 ..< 1)) / Float(ny)
                    
                    let ray = camera.getRay(u: u, v: v)
                    //let p = ray.pointAtParameter(t: 2.0) //why?
                    
                    color += world.getColor(ray: ray)
                }
                
                color /= Float(ns)
                
                pixelData.append(PixelData(fromVec3: color))
            }
        }
        
        let pixelImage = PixelImage(pixelData: pixelData, width: UInt(nx), height: UInt(ny))
        let image = pixelImage.toUIImage()
        
        imageView.image = image
    }
    
    fileprivate func generateTestImage() -> PixelImage {
        let nx = 200
        let ny = 100
        
        var pixelData: [PixelData] = [PixelData]()
        
        for j in (0 ..< ny).reversed() {
            for i in 0 ..< nx {
                let pixel: PixelData = PixelData(red: Float(i) / Float(nx),
                                                 green: Float(j) / Float(ny),
                                                 blue: 0.2)
                
                pixelData.append(pixel)
            }
        }
        
        return PixelImage(pixelData: pixelData, width: UInt(nx), height: UInt(ny))
    }
}

