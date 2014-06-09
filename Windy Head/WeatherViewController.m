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
    
    
    // Get screen height to configure the tables details
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    // Adding an image as an background
    UIImage* background = [UIImage imageNamed:@"weatherBackground.png"];
    
    self.weatherBackground = [[UIImageView alloc]initWithImage:background];
    
    [self.view addSubview:self.weatherBackground];
    
   
    // Setting up the TableView
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.1];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
}

// Configuring the UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 35;
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    self.weatherBackground.frame = bounds;
    self.tableView.frame = bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
