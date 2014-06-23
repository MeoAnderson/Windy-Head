//
//  FirstViewController.m
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//
//  "Windy Head" developed for Mobile Applications Development
//
// -----------------------------------------------------------------------

#import "FirstViewController.h"

@interface FirstViewController ()

@end


@implementation FirstViewController {
 
    CLLocationManager* locationLocator;
    
}

//-----------------------------------------------------------------------------------------------------------------------------------
// Detecting location and setting the map to zoom on it

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView.userLocation addObserver:self
                                forKeyPath:@"location"
                                   options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                                   context:NULL];
    
    CLLocation* location;
    
    MKCoordinateRegion region; //create a region.
    region.center = location.coordinate;
    // set the region center to your current location
    MKCoordinateSpan span; // create a range of your view
    span.latitudeDelta =  0.9;  // span dimensions.  I have BASE_RADIUS defined as 0.0144927536 which is equivalent to 1 mile
    span.longitudeDelta = 0.9;  // span dimensions
    region.span = span; // Set the region's span to the new span.
    [_mapView setRegion:region animated:YES]; // to
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    MKCoordinateRegion region;
    region.center = self.mapView.userLocation.coordinate;
    
    // Controlling the zoom
    
    MKCoordinateSpan span;
    span.latitudeDelta  = 0.04;
    span.longitudeDelta = 0.04;
    region.span = span;
    
    [self.mapView setRegion:region animated:YES];
}

//-----------------------------------------------------------------------------------------------------------------------------------
// Take the input from the keyboard and do a query with it

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
            annotations.subtitle = item.phoneNumber;
            annotations.observationInfo = item.observationInfo;
            [_mapView addAnnotation:annotations];
        }
        
    
        // To dismiss keyboard and validate text input
        [sender resignFirstResponder];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
