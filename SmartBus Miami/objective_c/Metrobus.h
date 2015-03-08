//
//  Metrobus.h
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/7/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Metrobus : NSObject

@property (strong, nonatomic) NSString *busId;
@property (strong, nonatomic) NSString *routeId;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *heading;

@property (strong, nonatomic) NSArray *busStops;

@property (nonatomic) BOOL hasLoggedIn;

-(void)setRouteId:(NSString *)routeId;
-(void)setBusId:(NSString *)busId;
-(void)setPosition:(NSString *)position;
-(void)setTime:(NSString *)time;
-(void)setHeading:(NSString *)heading;

-(void)setLoggedIn:(BOOL)hasLoggedIn;

@end
