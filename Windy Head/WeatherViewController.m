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
        // Custom initialization
        
    }
    return self;
}

- (void) Notifications {
    
    
    UILocalNotification* notification = [[UILocalNotification alloc]init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    notification.alertAction = @"Windy Head";
    notification.alertBody = @"Don't forget to check your tasks!";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (IBAction)getForecast:(id)sender {
    
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
