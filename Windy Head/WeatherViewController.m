//
//  WeatherViewController.m
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//

#import "WeatherViewController.h"


@interface WeatherViewController ()


@end


@implementation WeatherViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
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


// Event for button "Get Updated Forecast", including user location detection and weather data retrieval

//HERE BE BUTTON TO YE REFRESH ZE WEATHER

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Adding an image as an background
    UIImage* background = [UIImage imageNamed:@"weatherBackground.png"];
    
    self.weatherBackground = [[UIImageView alloc]initWithImage:background];
    
    [self.view addSubview:self.weatherBackground];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


/*
 CLLocation* location;
 
 Forecastr* forecast = [[Forecastr alloc]init];
 forecast.apiKey = @"98e0ab45fa7d9dff386046ed2f6f614c";
 forecast.cacheExpirationInMinutes = 5;
 forecast.units = @"ca";
 
 
 
 [forecast getForecastForLocation:location time:nil exclusions:nil extend:nil success:^(id JSON)
 {
 NSLog(@"JSON response was: %@", JSON);
 } failure:^(NSError *error, id response)
 {
 NSLog(@"Error while retrieving forecast: %@", [forecast messageForError:error withResponse:response]);
 }
 ];
 
 
 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Location and Weather Data"
 message:[NSString stringWithFormat:@"%@",forecast]
 delegate:nil
 cancelButtonTitle:@"Ok"
 otherButtonTitles:nil];
 
 
 [alert show];
 
 
 
*/
