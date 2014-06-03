//
//  MapsViewController.m
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController ()

@end
@implementation MapsViewController

@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) localSearchRequest {
    
    MKLocalSearchRequest* localSearch = [[MKLocalSearchRequest alloc]init];
    localSearch.naturalLanguageQuery = @"%d";
    //localSearch.region = _view.centerCoordinate;
    
    MKLocalSearch* search = [[MKLocalSearch alloc]initWithRequest:localSearch];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse* response, NSError* searchError) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
            else
                for (MKMapItem* item in response.mapItems) {
                    NSLog(@"Name = %@", item.name);
                    NSLog(@"Phone = %@", item.phoneNumber);
                }
     
        
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


/*
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [SearchDisplayController alloc];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        MKCoordinateSpan span;
        double radius = placemark.region.radius / 1000; // convert to km
        
        NSLog(@"[searchBarSearchButtonClicked] Radius is %f", radius);
        span.latitudeDelta = radius / 112.0;
        
        region.span = span;
        
    }];
}
*/
