//
//  ViewController.swift
//  LBAExtension
//
//  Created by Little_beta on 2024/7/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        var image: UIImage = UIImage(systemName: "book") ?? UIImage()
        image = image.lba_resizeImageWithMin(size: CGSize(width: 100, height: 100)) ?? UIImage()
        let imageView = UIImageView(frame: CGRect(x: 100, y: 300, width: 200, height: 200))
        imageView.contentMode = UIView.ContentMode.center
        imageView.image = image
        view.addSubview(imageView)
    }
}

