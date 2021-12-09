//
//  ViewController.swift
//  PollutionProject
//
//  Created by Dylan Cherrier on 06/12/2021.
//

import UIKit
import CoreLocation

class PictureVC: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takephoto: UIButton!
    @IBOutlet weak var sliderD: UISlider!
    @IBOutlet weak var stateBt: UIButton!
    @IBOutlet weak var priorityBt: UIButton!
    @IBOutlet weak var descriptionBt: UITextView!
    
    var locationManager = CLLocationManager()
    
    // lot of data for created a dump
    var image: UIImage?
    var positionX: Double? = 0
    var positionY: Double? = 0
    var degradation: Int? = 0
    var state = StatePollution.none
    var priority = PriorityLevel.none
    var textInfo: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionBt.delegate = self
        descriptionBt.returnKeyType = .done
        image = imageView.image
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
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
    // use this fonction when he take a picture or when he tap on button save
    private func takePosition(){
        if let x = locationManager.location?.coordinate.latitude{
            positionX = x
            //print(x)
        }
        if let y = locationManager.location?.coordinate.longitude{
            positionY = y
            //print(y)
        }
    }
    
    //MARK: Slider
    
    @IBAction func changeValueSliderD(_ sender: Any) {
        degradation = Int(sliderD.value)
        print(degradation!)
    }
    
    //MARK: State
    private func updateTitleState(){
        switch state{
        case .none:
            stateBt.setTitle("None", for: .normal)
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
        }
    }
    
    //MARK: Priority Level
    private func updateTitlePriority(){
        switch priority {
        case .none:
            priorityBt.setTitle("None", for: .normal)
        case .uncomfortable:
            priorityBt.setTitle("Uncomfortable", for: .normal)
        case .veryUncomfortable:
            priorityBt.setTitle("Very Uncomfortble", for: .normal)
        case .dangerous:
            priorityBt.setTitle("Dangerous", for: .normal)
        }
    }
    
    //MARK: Description
    
    /* cette partie est faite lorsque le mode edition de textView est fini*/
    
    //MARK: Pass Data & Data core
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stateSegue"{
            let stateView = segue.destination as! StatePopUpVC
            stateView.delegate = self
            stateView.state = state
        }else if segue.identifier == "prioritySegue"{
            let priorityView = segue.destination as! PriorityLVC
            priorityView.priorityDelegate = self
            priorityView.priority = priority
        }else if segue.identifier == "zoomSegue"{
            let zoomView = segue.destination as! ZoomVC
            //zoomView.priorityDelegate = self
            zoomView.image = self.image!
        }
    }
    
    /* Write here code for save data*/
    
    //MARK: Gesture
 
    @objc func doubleTap(_ sender: Any) {
        performSegue(withIdentifier: "zoomSegue", sender: self)
    }
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
        self.image = image
        imageView.image = image
        imageView.contentMode = .scaleToFill
        takePosition()
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
        if textView.text.isEmpty{
            descriptionBt.text = "Click here to add more information !"
            textInfo = nil
        }else{
            if let str = textView.text{
                textInfo = str
                //print(str)
            }
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

extension PictureVC: PriorityLevelDelegate{
    func priorityLevelButton(_ priority: PriorityLevel) {
        self.priority = priority
        self.updateTitlePriority()
    }
}

