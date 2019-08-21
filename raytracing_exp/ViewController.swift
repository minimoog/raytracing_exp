//
//  ViewController.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 8/20/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pixelImage = generateTestImage()
        
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

