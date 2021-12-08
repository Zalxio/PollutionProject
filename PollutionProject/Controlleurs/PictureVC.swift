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
    @IBOutlet weak var stateBt: UIButton!
    @IBOutlet weak var priorityBt: UIButton!
    @IBOutlet weak var descriptionBt: UITextView!
    
    var state = StatePollution.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionBt.delegate = self
        descriptionBt.returnKeyType = .done
    }
    
    //MARK: Piture
    // utilise UIImagePickerView pour prendre une photo
    @IBAction func takeAPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: localisation
    
    //MARK: State
    private func updateTitleState(){
        switch state{
        case .pollutedPlace:
            stateBt.setTitle("Polluted Place", for: .normal)
        case .abandonedObjects:
            stateBt.setTitle("Abandoned Objects", for: .normal)
        case .lighting:
            stateBt.setTitle("Lighting", for: .normal)
        case .floraWildlife:
            stateBt.setTitle("Flora & Wildlife", for: .normal)
        case .tag:
            stateBt.setTitle("Tag", for: .normal)
        case .none:
            stateBt.setTitle("None", for: .normal)
        }
    }
    
    //MARK: Priority Level
    
    //MARK: Description
    
    //MARK: Pass Data & Data core
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stateSegue"{
            let sView = segue.destination as! StatePopUpVC
            sView.delegate = self
            sView.state = state
        }
    }
    
    /* Write here code for save data*/
    
    
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

extension PictureVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionBt.backgroundColor = .systemGray5
        if descriptionBt.text == "Click here to add more information !"{
            descriptionBt.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        descriptionBt.backgroundColor = .white
        if let str = textView.text{
            print(str)
        }
        if descriptionBt.text.isEmpty{
            descriptionBt.text = "Click here to add more information !"
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            descriptionBt.resignFirstResponder()
            return false
        }
        return true
    }
    
}

extension PictureVC: StateVCDelegate{
    func stateButton(_ stateChoose: StatePollution) {
        self.state = stateChoose
        updateTitleState()
    }
}
