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
        
        let lowerLeftCorner = float3(-2.0, -1.0, -1.0)
        let horizontal = float3(4.0, 0.0, 0.0)
        let vertical = float3(0.0, 2.0, 0.0)
        let origin = float3(0.0, 0.0, 0.0)
        
        let world = [Sphere(center: float3(0.0, 0.0, -1.0), radius: 0.5),
                                  Sphere(center: float3(0.0, -100.5, -1.0), radius: 100)]
        
        var pixelData: [PixelData] = [PixelData]()
        
        for j in (0 ..< ny).reversed() {
            for i in 0 ..< nx {
                let u = Float(i) / Float(nx)
                let v = Float(j) / Float(ny)
                
                let ray: Ray = Ray(origin: origin, direction: lowerLeftCorner + u * horizontal + v * vertical)
                let color = world.getColor(ray: ray)
                
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

