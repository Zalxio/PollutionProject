//
//  MapVC.swift
//  PollutionProject
//
//  Created by Dylan Cherrier on 06/12/2021.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let managerLoc = CLLocationManager()
    let zoom: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Localisation
        locationServices()
    }
    
    //MARK: Localisation
    
    // vérifie si le service de localisation est activer
    private func locationServices(){
        if CLLocationManager.locationServicesEnabled(){
            initLocation()
            locationAuthorization()
        }else{
            
        }
    }
    
    // initialise la localisation et la position
    private func initLocation(){
        managerLoc.delegate = self
        managerLoc.desiredAccuracy = kCLLocationAccuracyReduced
    }
    
    // vérifie l'authorisation accorder par l'utillisateur pour l'utilisation du sevice de localisation
    private func locationAuthorization(){
        switch managerLoc.authorizationStatus{
        case .authorizedAlways :        // toujours authorise (cas : mise à jour du trajet en arrière plan)
            break
        case .authorizedWhenInUse :     // que lorsque l'app est au premier plan et utiliser (cas : localisation)
            mapView.showsUserLocation = true    // afficher localisation de l'utilisateur
            mapView.showsCompass = true
            mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
            break
        case .restricted :              // ex: restraint par un parent le statut ne peut etre modifier
            break
        case .denied :                  // app non authoriser a utiliser le service de localisation
            break
        case .notDetermined:            // pas encore déterminer
            break
        @unknown default:
            break
        }
    }

}

extension MapVC: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorization()     // vérifie l'authorisation quand il change
    }
}

extension MapVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        print("change")
    }
}
