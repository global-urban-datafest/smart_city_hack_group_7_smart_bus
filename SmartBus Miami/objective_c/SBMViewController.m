//
//  SBMViewController.m
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/7/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import "SBMViewController.h"

@interface SBMViewController ()



- (IBAction)submitButton:(UIButton *)sender;

//@property (weak, nonatomic) IBOutlet UITextView *responseTextView;

@end

@implementation SBMViewController

/*
- (void)startTracking {
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    CLLocation *lastLocation = [locations lastObject];
    NSLog(@"%@",lastLocation.description);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
    
}
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager{
    
}

-(void)stopTracking{
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:YES];
    [self startTracking];
}
- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:CLLocationDistanceMax];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisppear");
    [super viewWillDisappear:YES];
    [self stopTracking];
}
*/

-(void)startSession
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
}

-(NSString *)constructUrlString
{
    NSString *busIdStringSegment = [self.busIdParameter stringByAppendingString:self.bus.busId];
    NSLog(@"busIdStringSegment: %@",busIdStringSegment);
    
    NSString *routeIdStringSegment = [self.routeIdParameter stringByAppendingString:self.bus.routeId];
    NSLog(@"routeIdStringSegment: %@",routeIdStringSegment);
    
    NSString *positionStringSegment = [self.positionParameter stringByAppendingString:self.bus.position];
    NSLog(@"positionStringSegment: %@",positionStringSegment);
    
    NSString *headingStringSegment = [self.headingParameter stringByAppendingString:self.bus.heading];
    NSLog(@"headingStringSegment: %@",headingStringSegment);
    
    NSString *timeStringSegment = [self.timeParameter stringByAppendingString:[TimeStamp mds_stringWithEncoding:NSUTF8StringEncoding]];
    NSLog(@"timeStringSegment: %@",timeStringSegment);
    
    NSString *urlString = [self.serverAddress stringByAppendingString:
                           [busIdStringSegment stringByAppendingString:
                            //     [routeIdStringSegment stringByAppendingString:
                            [timeStringSegment stringByAppendingString:
                             //   [headingStringSegment stringByAppendingString:
                             positionStringSegment]]];
    return urlString;
}

- (IBAction)submitButton:(UIButton *)sender {
    NSLog(@"submitButtonTapped");
    [self startSession];
    
    NSString *urlString = [self constructUrlString];
    
    //urlString = [urlString mds_stringWithEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    //Do the strong/weak hokey pokey to avoid creating a memory cycle
   // __weak SBMViewController *weakSelf = self;
    
    self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                     {
                         if (error) {
                             
                             NSString *responseUrl = @"**no response URL provided**";
                             
                             if (response.URL){
                                 responseUrl = [response.URL absoluteString];
                             }
                             NSLog(@"Session with response URL: %@ encountered error: %@.",response.URL,error);\
                             //[self.delegate uploadService:self didFailToCompleteOperationWithError:error];
                         } else {
                             NSString *serverResponse = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                             NSLog(@"Server returned a response with %lu characters. \nResponse: %@",[serverResponse length],serverResponse);
                         }
                     }];
    //The data task is paused by default upon creation, so we must resume it
    [self.dataTask resume];
}

- (NSString *)serverAddress {
    if (!_serverAddress) {
        _serverAddress = @"http://10.108.6.159/driver.php?";
    }
    return _serverAddress;
}
- (NSString *)busIdParameter {
    if (!_busIdParameter) {
        _busIdParameter = @"busId=";
    }
    return _busIdParameter;
}
- (NSString *)timeParameter {
    if (!_timeParameter) {
        _timeParameter = @"&time=";
    }
    return _timeParameter;
}
- (NSString *)positionParameter {
    if (!_positionParameter) {
        _positionParameter = @"&position=";
    }
    return _positionParameter;
}
- (NSString *)routeIdParameter {
    if (!_routeIdParameter) {
        _routeIdParameter = @"&routeId=";
    }
    return _routeIdParameter;
}
- (NSString *)headingParameter {
    if (!_headingParameter) {
        _headingParameter = @"&heading=";
    }
    return _headingParameter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
