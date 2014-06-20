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
}

@end


@implementation WeatherViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}





// Once the view is loaded, this will run first
// Location detection
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
        
}




// This function has two major goals: User location detection, and return the forecast information acording the location
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
            _city.alpha = 0;
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                             animations:^{ _city.alpha = 1;}
                             completion:nil];
            
            NSLog(@"You are in %@.", placemark.locality);
        }
        
    }
     
     
     
     ];
    
    // Forecast API initialization & setup
    
    Forecastr* forecast = [[Forecastr alloc]init];
    forecast.apiKey = @"013285791a63a2a6b4fa791029b75bf3";
    forecast.cacheExpirationInMinutes = 1;
    forecast.units = @"ca";
    
    
    // Get forecast data (according users location)
    [forecast getForecastForLocation:currentLocation time:nil exclusions:nil extend:nil success:^(id JSON){
        
        NSLog(@"JSON response was: %@", JSON);
        
        NSDictionary* weatherData = [(NSDictionary *)JSON objectForKey:kFCCurrentlyForecast];
        
        [self updateWeatherData:weatherData];
        
        }
     
                             failure:^(NSError *error, id response){
                                 
                                 
                                 
                                 NSLog(@"Error while retrieving forecast: %@", [forecast messageForError:error withResponse:response]);
                                 
                                 
                             }];
    
    
}

// Update storyboard labels with weather data, with a fade-in effect

- (void) updateWeatherData:(NSDictionary *) weatherData{
    
    
    NSString *actualTemperature = [NSString stringWithFormat:@"Temperature: %.1f C°", [[weatherData objectForKey:kFCTemperature] doubleValue]];
    self.temperature.text = actualTemperature;
    _temperature.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _temperature.alpha = 1;}
                     completion:nil];

    
    NSString *actualState = [NSString stringWithFormat:@"Current Weather State: %@", [weatherData objectForKey:kFCSummary]];
    self.state.text = actualState;
    _state.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _state.alpha = 1;}
                     completion:nil];

    
    NSString *actualWindSpeed = [NSString stringWithFormat:@"Wind Speed: %@ km/h", [weatherData objectForKey:kFCWindSpeed]];
    self.windSpeed.text = actualWindSpeed;
    _windSpeed.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _windSpeed.alpha = 1;}
                     completion:nil];

    
    NSString *actualAtmosphericPressure = [NSString stringWithFormat:@"Atmospheric Pressure: %@ mb", [weatherData objectForKey:kFCPressure]];
    self.pressure.text = actualAtmosphericPressure;
    _pressure.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _pressure.alpha = 1;}
                     completion:nil];

    
    NSString *actualHumidity = [NSString stringWithFormat:@"Humidity: %@", [weatherData objectForKey:kFCHumidity]];
    self.humidity.text = actualHumidity;
    _humidity.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _humidity.alpha = 1;}
                     completion:nil];


    
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
 



 // Use reverse geocoding to get the location string (and display it)
 
 [reverseGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
 
 city.text = [NSString stringWithFormat:@"%@",placemark.locality];
 
 NSLog(@"Found %@", placemark.locality);
 
 }];
 
 
 
 
 
 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Location and Weather Data"
 message:[NSString stringWithFormat:@"%@",forecast]
 delegate:nil
 cancelButtonTitle:@"Ok"
 otherButtonTitles:nil];
 
 [alert show];
 
 
 NSDictionary *currentConditions = [(NSDictionary *)JSON objectForKey:kFCCurrentlyForecast];
 
 [self updateDisplayWithCurrentConditions:currentConditions];
 
 
 
 
 
 
 NSDictionary *weatherDescription = [(NSDictionary *)JSON objectForKey:kFCCurrentlyForecast];
 self.temperature.text = [NSString stringWithFormat:@"Temperature: %.1f C°", [[weatherDescription objectForKey:kFCTemperature] doubleValue]];
 
 NSDictionary *stateDescription = [(NSDictionary *)JSON objectForKey:kFCCurrentlyForecast];
 self.temperature.text = [NSString stringWithFormat:@"Weather State: %@", [stateDescription objectForKey:kFCSummary]];
 
 
 
 
 */