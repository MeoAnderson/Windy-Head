//
//  WeatherViewController.m
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//

#import "WeatherViewController.h"


@interface WeatherViewController ()

{
    CLLocationManager *locationManager;
    Forecastr *forecastr;
}

@end


@implementation WeatherViewController


// Synthetizing the UILabels
//@synthesize locationManager;
@synthesize city;
@synthesize state;
@synthesize temperature;
@synthesize pressure;
@synthesize windSpeed;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


// EXPLAIN
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
        
}

// Notifications - Still not working as it should, only appear after an event turns them on - TBR

- (void) Notifications {
    
    UILocalNotification* notification = [[UILocalNotification alloc]init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    notification.alertAction = @"Windy Head";
    notification.alertBody = @"Don't forget to check your daily tasks!";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}
//EXPLAIN IN A LOT OF DETAIL
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    
    CLLocation *currentLocation = newLocation;
    CLGeocoder* geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"Discovering address");
        if (error) {
            NSLog(@"Couldn't get location %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            self.city.text = [NSString stringWithFormat:@"%@", placemark.locality];
            NSLog(@"Found %@", placemark.locality);
        }
        
    }];
    
    Forecastr* forecast = [[Forecastr alloc]init];
    forecast.apiKey = @"013285791a63a2a6b4fa791029b75bf3";
    forecast.cacheExpirationInMinutes = 1;
    forecast.units = @"ca";
    
    
    // Get forecast data from Forecast API
    [forecast getForecastForLocation:currentLocation time:nil exclusions:nil extend:nil success:^(id JSON)
     {
         NSLog(@"JSON response was: %@", JSON);
     } failure:^(NSError *error, id response)
     {
         NSLog(@"Error while retrieving forecast: %@", [forecast messageForError:error withResponse:response]);
     }
     ];

    
}



// Event for button "Get Updated Forecast", including user location detection and weather data retrieval


- (IBAction)updateForecast:(id)sender {
    
    [locationManager startUpdatingLocation];

}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


/*
//Leftover code

UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Location and Weather Data"
                                                message:[NSString stringWithFormat:@"%@",forecast]
                                               delegate:nil
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil];
 */


/*
 UIActivityIndicatorView* activityUpdatingForecast = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
 
 
 activityUpdatingForecast.center = CGPointMake(500, 500);
 
 [activityUpdatingForecast startAnimating];
 */


/*
 // Use reverse geocoding to get the location string (and display it)
 
 [reverseGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
 
 city.text = [NSString stringWithFormat:@"%@",placemark.locality];
 
 NSLog(@"Found %@", placemark.locality);
 
 }];
 */
