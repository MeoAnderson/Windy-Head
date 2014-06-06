//
//  FirstViewController.m
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end


@implementation FirstViewController {
 
    CLLocationManager* locationLocator;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

- (void) discoverCurrentLocation {
    
    CLLocationManager* locationDetector = [[CLLocationManager alloc]init];
   
    locationDetector.desiredAccuracy = kCLLocationAccuracyBest;
    locationDetector.distanceFilter = kCLDistanceFilterNone;
    
    [locationDetector startUpdatingLocation];
    
    
    //CLLocationCoordinate2D currentLocation = [[[_mapView userLocation] location] coordinate];
    //NSLog(@"You are at: %f %f",currentLocation.latitude,currentLocation.longitude);

    
}


- (IBAction)searchBox:(UITextField*)sender {

    MKLocalSearchRequest* searchRequest = [[MKLocalSearchRequest alloc]init];
    
    searchRequest.naturalLanguageQuery = _searchBar.text;
    searchRequest.region = _mapView.region;
    
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
    {
        NSLog(@"Map Items: %@", response.mapItems);
        
        
        for (MKMapItem *item in response.mapItems)
        {
       
            MKPointAnnotation *annotations = [[MKPointAnnotation alloc]init];
            annotations.coordinate = item.placemark.coordinate;
            annotations.title = item.name;
            [_mapView addAnnotation:annotations];
        }
    
        // To dismiss keyboard and validate
        [sender resignFirstResponder];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
