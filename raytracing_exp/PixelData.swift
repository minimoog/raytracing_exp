//
//  PixelData.swift
//  raytracing_exp
//
//  Created by Antonie Jovanoski on 8/20/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

public struct PixelData {
    var a: UInt8 = 255
    var r: UInt8
    var g: UInt8
    var b: UInt8
}

public func imageFromPixelData(pixels: [PixelData], width: UInt, height: UInt) -> UIImage? {
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
    
    let bitsPerComponent: UInt = 8
    let bitsPerPixel: UInt = 32
    let pixelDataSize = MemoryLayout<PixelData>.size
    
    assert(pixels.count == Int(width * height))
    
    let data: Data = pixels.withUnsafeBufferPointer { return Data(buffer: $0) }
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