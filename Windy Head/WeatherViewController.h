//
//  WeatherViewController.h
//  Windy Head
//
//  Created by Vasco Patrício on 28/05/14.
//  Copyright (c) 2014 ISCTE-IUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Forecastr.h>
#import <Forecastr+CLLocation.h>
#import <ForecastrAPIClient.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface WeatherViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *updateForecast;

// Placeholder labels to be updated with data from Forecast API

@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UILabel *pressure;
@property (strong, nonatomic) IBOutlet UILabel *windSpeed;
@property (strong, nonatomic) IBOutlet UILabel *humidity;

@end