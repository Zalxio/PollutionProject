//
//  PriorityLVC.swift
//  PollutionProject
//
//  Created by Dylan Cherrier on 08/12/2021.
//

import UIKit

protocol PriorityLevelDelegate{
    func priorityLevelButton(_ priority: PriorityLevel)
}

class PriorityLVC: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var priority = PriorityLevel.none
    var priorityDelegate: PriorityLevelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designView()
        designPopup()
        initButtons()
    }
    
    //MARK: View
    private func designPopup(){
        popUpView.layer.cornerRadius = 20
        popUpView.backgroundColor = .systemGray4
    }
    
    private func designView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at:0)
    }
    
    //MARK: buttons
    private func initButtons(){
        switch priority {
        case .none:
            buttons[priority.rawValue].isEnabled = false
        case .uncomfortable:
            buttons[priority.rawValue].isEnabled = false
        case .veryUncomfortable:
            buttons[priority.rawValue].isEnabled = false
        case .dangerous:
            buttons[priority.rawValue].isEnabled = false
        }
    }
    
    @IBAction func actionPriorityOne(_ sender: Any) {
        self.updateState(PriorityLevel.none)
    }
    
    @IBAction func actionPriorityTwo(_ sender: Any) {
        self.updateState(PriorityLevel.uncomfortable)
    }
    
    @IBAction func actionPriorityThree(_ sender: Any) {
        self.updateState(PriorityLevel.veryUncomfortable)
    }
    
    @IBAction func actionPriorityFour(_ sender: Any) {
        self.updateState(PriorityLevel.dangerous)
    }
    
    private func updateState(_ newPriority: PriorityLevel){
        if priority != newPriority{
            buttons[priority.rawValue].isEnabled = true
            priority = newPriority
            buttons[priority.rawValue].isEnabled = false
        }
    }
    
    //MARK: Pass data
    @IBAction func cancelButton(_ sender: Any) {
        priorityDelegate?.priorityLevelButton(priority)
        print(priority)
        dismiss(animated: true, completion: nil)
    }
}

enum PriorityLevel: Int{
    case none = 0;
    case uncomfortable = 1;
    case veryUncomfortable = 2;
    case dangerous = 3;
}
