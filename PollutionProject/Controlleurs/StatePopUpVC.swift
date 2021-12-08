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
    
    @IBOutlet weak var contentview: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var state = StatePollution.none
    var delegate: StateVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPopup()
        initButtons()
        print(state)
    }
    
    //MARK: View
    private func designPopup(){
        contentview.layer.cornerRadius = 20
        contentview.backgroundColor = .systemGray5
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
        updateState(StatePollution.pollutedPlace)
    }
    
    @IBAction func actionStateTwo(_ sender: Any) {
        updateState(StatePollution.abandonedObjects)
    }
    
    @IBAction func actionStateThree(_ sender: Any) {
        updateState(StatePollution.lighting)
    }
    
    @IBAction func actionStateFour(_ sender: Any) {
        updateState(StatePollution.floraWildlife)
    }
    
    @IBAction func actionStateFive(_ sender: Any) {
        updateState(StatePollution.tag)
    }
    
    @IBAction func actionStateSix(_ sender: Any) {
        updateState(StatePollution.none)
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
    case pollutedPlace = 0;
    case abandonedObjects = 1;
    case lighting = 2;
    case floraWildlife = 3;
    case tag = 4;
    case none = 5;
}
