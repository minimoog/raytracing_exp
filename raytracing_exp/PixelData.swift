//
//  PixelData.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 8/20/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit
import simd

public struct PixelData {
    var a: UInt8 = 255
    var r: UInt8 = 0
    var g: UInt8 = 0
    var b: UInt8 = 0
    
    init(red: Float, green: Float, blue: Float) {
        r = UInt8(255.99 * red)
        g = UInt8(255.99 * green)
        b = UInt8(255.99 * blue)
    }
    
    init(fromVec3: float3) {
        let clamped = clamp(fromVec3, min: 0.0, max: 1.0)
        
        r = UInt8(255.99 * clamped.x)
        g = UInt8(255.99 * clamped.y)
        b = UInt8(255.99 * clamped.z)
    }
}

public struct PixelImage {
    var pixelData: [PixelData] = [PixelData]()
    var width: UInt = 0
    var height: UInt = 0
    
    public func toUIImage() -> UIImage? {
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        let bitsPerComponent: UInt = 8
        let bitsPerPixel: UInt = 32
        let pixelDataSize = MemoryLayout<PixelData>.size
        
        assert(pixelData.count == Int(width * height))
        
        let data: Data = pixelData.withUnsafeBufferPointer { return Data(buffer: $0) }
        let cfData = NSData(data: data) as CFData
        
        guard let provider = CGDataProvider(data: cfData) else { return nil }
        
        guard let cgImage = CGImage(width: Int(width),
                                    height: Int(height),
                                    bitsPerComponent: Int(bitsPerComponent),
                                    bitsPerPixel: Int(bitsPerPixel),
                                    bytesPerRow: Int(width) * pixelDataSize,
                                    space: CGColorSpaceCreateDeviceRGB(),
                                    bitmapInfo: bitmapInfo,
                                    provider: provider,
                                    decode: nil,
                                    shouldInterpolate: false,
                                    intent: .defaultIntent)
            else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}
