//
//  ViewController.swift
//  PollutionProject
//
//  Created by Dylan Cherrier on 06/12/2021.
//

import UIKit

class PictureVC: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takephoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    //MARK: Piture
    // utilise UIImagePickerView pour prendre une photo
    @IBAction func takeAPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    //
    
    //MARK: location
}

extension PictureVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // quitte le pickerView
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // quitte le pickerview et recupère/affiche l'image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{return}
        imageView.image = image
        imageView.contentMode = .scaleToFill
    }
}
