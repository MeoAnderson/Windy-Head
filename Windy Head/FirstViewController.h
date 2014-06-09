//
//  FirstViewController.h
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic, assign) NSArray* mapItems;
@property (strong, nonatomic) IBOutlet UITextField *searchBar;


@end
