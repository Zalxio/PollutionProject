//
//  ZoomVC.swift
//  PollutionProject
//
//  Created by Dylan Cherrier on 09/12/2021.
//

import UIKit

class ZoomVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

}
