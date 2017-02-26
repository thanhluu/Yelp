//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!

    var searchBar = UISearchBar()
    var businesses: [Business]!
    
    @IBAction func switchLayout(_ sender: AnyObject) {
        tableView.isHidden = sender.selectedSegmentIndex == 1
        mapView.isHidden = sender.selectedSegmentIndex == 0
        if (sender.selectedSegmentIndex == 0) {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Setup Map View
        mapView.isHidden = true
        mapView.isZoomEnabled = true
        let centerLocation = CLLocation(latitude: defaultLocation[0] , longitude: defaultLocation[1])
        goToLocation(location: centerLocation)
        
        // Setup Search Bar
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar

        navigationController?.navigationBar.barTintColor = UIColor.red
        
        doFilter()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let filterVC = navVC.topViewController as! FiltersViewController
        
        filterVC.delegate = self
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    // add an Annotation with a coordinate: CLLocationCoordinate2D
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "An annotation!"
        mapView.addAnnotation(annotation)
    }
    
    // add an annotation with an address: String
    func addAnnotationAtAddress(address: String, title: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
}

extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses == nil {
            return 0
        } else {
            return businesses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }

    func filtersViewControllerDidUpdate(_ filtersViewController: FiltersViewController) {
        doFilter()
    }
    
    fileprivate func doFilter() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Business.search(with: searchBar.text!, sort: BusinessFilterSettings.sharedInstance.sort, categories: BusinessFilterSettings.sharedInstance.categories, deals: BusinessFilterSettings.sharedInstance.deals, distance: BusinessFilterSettings.sharedInstance.distance) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                
                for business in businesses {
                    self.addAnnotationAtAddress(address: business.address!, title: business.name!)
                }
                
                self.tableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doFilter()
    }
}


