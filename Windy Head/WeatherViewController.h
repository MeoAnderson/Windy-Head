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

// test code with  UITableView for weather data
@interface WeatherViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* weatherBackground;
@property (nonatomic, assign) CGFloat screenHeight;



/*

    __weak IBOutlet UILabel *locationWeather;
    
    __weak IBOutlet UILabel *temperature;
    
    __weak IBOutlet UILabel *maxTemperature;
    
    __weak IBOutlet UILabel *minTemperature;
    
    __weak IBOutlet UILabel *windSpeed;

*/

@end
