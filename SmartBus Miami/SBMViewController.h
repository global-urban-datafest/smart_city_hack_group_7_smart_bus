//
//  SBMViewController.h
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/7/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NSString+MDSApplicationSpecific.h"
#import "Metrobus.h"

#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]

@interface SBMViewController : UIViewController <CLLocationManagerDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) NSMutableArray *trackPointArray;

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

@property (strong, nonatomic) NSString *serverAddress;
@property (strong, nonatomic) NSString *busIdParameter;
@property (strong, nonatomic) NSString *timeParameter;
@property (strong, nonatomic) NSString *positionParameter;
@property (strong, nonatomic) NSString *routeIdParameter;
@property (strong, nonatomic) NSString *headingParameter;

@property (strong, nonatomic) Metrobus *bus;

- (void)startSession;

- (NSString *)serverAddress;
- (NSString *)busIdParameter;
- (NSString *)timeParameter;
- (NSString *)positionParameter;
- (NSString *)routeIdParameter;
- (NSString *)headingParameter;

- (NSString *)constructUrlString;

//- (void)setBus;

//-(void)startTracking;
//-(void)stopTracking;

@end