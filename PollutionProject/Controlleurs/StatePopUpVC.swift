//
//  PopUpVC.swift
//  PollutionProject
//
//  Created by Dylan Cherrier on 08/12/2021.
//

import UIKit

protocol StateVCDelegate{
    func stateButton(_ stateChoose:StatePollution)
}

class StatePopUpVC: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var state = StatePollution.none
    var delegate: StateVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designView()
        designPopup()
        initButtons()
        //print(state)
    }
    
    //MARK: View
    private func designPopup(){
        popUpView.layer.cornerRadius = 20
        popUpView.backgroundColor = .systemGray5
    }
    
    private func designView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at:0)
    }
    
    //MARK: buttons
    // initialisation des bouttons
    private func initButtons(){
        switch state {
        case .pollutedPlace:
            buttons[state.rawValue].isEnabled = false
        case .abandonedObjects:
            buttons[state.rawValue].isEnabled = false
        case .lighting:
            buttons[state.rawValue].isEnabled = false
        case .floraWildlife:
            buttons[state.rawValue].isEnabled = false
        case .tag:
            buttons[state.rawValue].isEnabled = false
        case .none:
            buttons[state.rawValue].isEnabled = false
        }
    }
    
    @IBAction func actionStateOne(_ sender: Any) {
        updateState(StatePollution.none)
    }
    
    @IBAction func actionStateTwo(_ sender: Any) {
        updateState(StatePollution.pollutedPlace)
    }
    
    @IBAction func actionStateThree(_ sender: Any) {
        updateState(StatePollution.abandonedObjects)
    }
    
    @IBAction func actionStateFour(_ sender: Any) {
        updateState(StatePollution.lighting)
    }
    
    @IBAction func actionStateFive(_ sender: Any) {
        updateState(StatePollution.floraWildlife)
    }
    
    @IBAction func actionStateSix(_ sender: Any) {
        updateState(StatePollution.tag)
    }
    
    private func updateState(_ newState: StatePollution){
        if state != newState{
            buttons[state.rawValue].isEnabled = true
            state = newState
            buttons[state.rawValue].isEnabled = false
        }
    }
    
    //MARK: Pass data
    @IBAction func cancelButton(_ sender: Any) {
        delegate?.stateButton(state)
        print(state)
        dismiss(animated: true, completion: nil)
    }
}

enum StatePollution : Int{
    case none = 0;
    case pollutedPlace = 1;
    case abandonedObjects = 2;
    case lighting = 3;
    case floraWildlife = 4;
    case tag = 5;
}
