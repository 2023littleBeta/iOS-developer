//
//  LBAImage.swift
//  LBAExtension
//
//  Created by Little_beta on 2024/7/28.
//

import Foundation
import UIKit

extension CGFloat {
    func isZero() -> Bool {
        return abs(self) < CGFLOAT_EPSILON
    }
}

extension UIImage {
    
    // MARK: UIImage Resize CGSize
    /*
        Resizes the image to fit within the given maximum size while maintaining the aspect ratio.
    */
    func lba_resizeImageWithMax(size maxSize: CGSize) -> UIImage? {
        var resultImage: UIImage?
        if (maxSize.width >= self.size.width && maxSize.height >= self.size.height) {
            resultImage = self
        } else {
            if (maxSize.width.isZero || maxSize.height.isZero || self.size.width.isZero || self.size.height.isZero) {
                return nil
            }
            let imageRatio = self.size.width / self.size.height
            let containerRatio = maxSize.width / maxSize.height
            var targetWidth: CGFloat
            var targetHeight: CGFloat
            if (imageRatio > containerRatio) {
                targetWidth = maxSize.width
                targetHeight = targetWidth / imageRatio
            } else {
                targetHeight = maxSize.height
                targetWidth = targetHeight * imageRatio;
            }
            let rendererFormat: UIGraphicsImageRendererFormat = UIGraphicsImageRendererFormat()
            rendererFormat.opaque = false
            rendererFormat.scale = self.scale
            let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer()
            resultImage = renderer .image(actions: { UIGraphicsImageRendererContext in
                self.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
            });
        }
        return resultImage
    }
    
    /*
        Resizes the image to fit within the given minimum size while maintaining the aspect ratio.
    */
    func lba_resizeImageWithMin(size minSize: CGSize) -> UIImage? {
        var resultImage: UIImage?
        if (minSize.width <= self.size.width && minSize.height <= self.size.height) {
            resultImage = self
        } else {
            if (minSize.width.isZero || minSize.height.isZero || self.size.width.isZero || self.size.height.isZero) {
                return nil
            }
            let imageRatio = self.size.width / self.size.height
            let containerRatio = minSize.width / minSize.height
            var targetWidth: CGFloat
            var targetHeight: CGFloat
            if (imageRatio > containerRatio) {
                targetWidth = minSize.width
                targetHeight = targetWidth / imageRatio
            } else {
                targetHeight = minSize.height
                targetWidth = targetHeight * imageRatio;
            }
            let rendererFormat: UIGraphicsImageRendererFormat = UIGraphicsImageRendererFormat()
            rendererFormat.opaque = false
            rendererFormat.scale = self.scale
            let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: CGSize(width: targetWidth, height: targetHeight), format: rendererFormat)
            resultImage = renderer.image(actions: { UIGraphicsImageRendererContext in
                self.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
            });
        }
        return resultImage
    }
    
    func lba_resizeImageWithMax(dataSize: Double) -> Data? {
        var compression = 1.0
        var currentData = self.jpegData(compressionQuality: compression)
        var sizeInKB = Double(currentData?.count ?? 0) / 1024.0
        if sizeInKB < dataSize {
            return currentData
        }
        var end: Int = 9, middle: Int = 0, len: Int = 10, half: Int = 0
        while (len > 0) {
            autoreleasepool {
                half = len >> 1
                middle = end - half
                currentData = self.jpegData(compressionQuality: Double(middle) / 10.0)
                sizeInKB = Double(currentData?.count ?? 0) / 1024.0
                if (sizeInKB > dataSize) {
                    end = middle - 1
                    len = len - half - 1
                } else {
                    len = half
                }
            }
        }
        compression = Double(max(end, 0)) / 10
        currentData = self.jpegData(compressionQuality: compression)
        return currentData
    }
}
