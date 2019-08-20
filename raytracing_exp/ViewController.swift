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
        
        let width = imageView.image?.cgImage?.width
        let height = imageView.image?.cgImage?.height
        
        let lenght = 200
        let redPixel = PixelData(a: 255, r: 192, g: 0, b: 0)
        let pixelData = [PixelData](repeating: redPixel, count: lenght * lenght)
        
        let image = imageFromPixelData(pixels: pixelData, width: UInt(lenght), height: UInt(lenght))
        
        imageView.image = image
        
        print("Width \(String(describing: width)) and height \(String(describing: height))")
    }
}

