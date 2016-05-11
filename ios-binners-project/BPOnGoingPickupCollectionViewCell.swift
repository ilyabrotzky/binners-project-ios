//
//  BPOnGoingPickupCollectionViewCell.swift
//  ios-binners-project
//
//  Created by Matheus Ruschel on 5/5/16.
//  Copyright © 2016 Rodrigo de Souza Reis. All rights reserved.
//

import UIKit
import GoogleMaps

class BPOnGoingPickupCollectionViewCell: UICollectionViewCell {
    
    var pickup: BPPickup! {
        didSet{
            setupCell()
        }
    }
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var labelPickupStatus: UILabel!
    @IBOutlet weak var labelDateText: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelBinnerText: UILabel!
    @IBOutlet weak var labelBinnerName: UILabel!
    @IBOutlet weak var labelTimeText: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var cancelPickupButton: UIButton!
    let formatter:NSDateFormatter = NSDateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
        setupViewCorners()
        setupLabels()
        cancelPickupButton.imageView?.contentMode = .ScaleAspectFit
        cancelPickupButton.imageView!.image = cancelPickupButton.imageView!.image!.imageWithRenderingMode(.AlwaysTemplate)
        cancelPickupButton.tintColor = UIColor.grayColor()
    }
    
    func setupLabels() {
        labelPickupStatus.font = UIFont.boldSystemFontOfSize(labelPickupStatus.font.pointSize)
        labelTime.font = UIFont.boldSystemFontOfSize(13)
        labelBinnerName.font = UIFont.boldSystemFontOfSize(13)
        labelDate.font = UIFont.boldSystemFontOfSize(13)
        
        labelTimeText.font = UIFont.boldSystemFontOfSize(12)
        labelBinnerText.font = UIFont.boldSystemFontOfSize(12)
        labelDateText.font = UIFont.boldSystemFontOfSize(12)
        
        labelBinnerName.textColor = UIColor.binnersGreenColor()
        labelBinnerText.textColor = UIColor.grayColor()
        labelTimeText.textColor = UIColor.grayColor()
        labelDateText.textColor = UIColor.grayColor()
        labelPickupStatus.textColor = UIColor.binnersGreenColor()

    }
    
    func setupCell() {
        labelPickupStatus.text = "Completed"
        formatter.timeStyle = .NoStyle
        formatter.dateStyle = .ShortStyle
        labelDate.text = formatter.stringFromDate(pickup.date)
        labelBinnerName.text = "Adam"
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .NoStyle
        labelTime.text = formatter.stringFromDate(pickup.date)
        let location = CLLocation(latitude: pickup.address.location.latitude, longitude: pickup.address.location.longitude)
        centerMapOnLocation(location)
        
        mapView.userInteractionEnabled = false
    }
    
    func setupViewCorners() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 7.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSizeMake(-2.0, 2.0)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        self.mapView.camera = GMSCameraPosition.cameraWithTarget(location.coordinate, zoom: 15.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
}