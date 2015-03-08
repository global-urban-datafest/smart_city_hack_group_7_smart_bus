//
//  Metrobus.m
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/7/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import "Metrobus.h"

@interface Metrobus ()



@end

@implementation Metrobus

@synthesize busId = _busId;
@synthesize routeId = _routeId;
@synthesize position = _position;
@synthesize time = _time;
@synthesize heading = _heading;
@synthesize busStops = _busStops;
@synthesize hasLoggedIn = _hasLoggedIn;

-(instancetype)init{
    if (self = [super init])
    {
        _busStops = [[NSArray alloc] initWithObjects:
                     @"FIU Main Campus, University Park, FL",
                     @"SW 24 St & 88 Ave, Westchester, FL",
                     @"SW 87th Ave & SW 24th St, Miami, FL",
                     @"SW 82 Ave & 24 St, Westchester, FL",
                     @"SW 8th St & SW 87th Ave, Miami, FL",
                     @"SW 8th St & SW 57th Ave, Miami, FL",
                     @"SW 8th St & SW 42nd Ave, Miami, FL",
                     @"SW 8th St & SW 27th Ave, Miami, FL",
                     @"SW 8th St & SW 12th Ave, Miami, FL",
                     @"Brickell STA@SW 1 Av (West Side), Miami, FL ",
                     @"NE 1 a/NE 4 S - (Miami Dade College), Miami, FL",
                     nil];
        
        NSLog(@"Initializing busStops with element count: %lu", [_busStops count]);
        
        
    };
    
    return self;
}
-(void)setRouteId:(NSString *)routeId{
    _routeId = routeId;
}

-(void)setBusId:(NSString *)busId{
    _busId = busId;
}

-(void)setPosition:(NSString *)position{
    _position = position;
}

-(void)setTime:(NSString *)time{
    _time = time;
}

-(void)setHeading:(NSString *)heading{
    _heading = heading;
}

-(void)setHasLoggedIn:(BOOL)hasLoggedIn{
    _hasLoggedIn = hasLoggedIn;
}
/*
-(NSDictionary *)busStops{
    if (!self.busStops){
        self.busStops = [[NSDictionary alloc] initWithObjectsAndKeys:@"FIU Main Campus, University Park, FL",@"1", @"SW 24 St & 88 Ave, Westchester, FL",@"2", @"Southwest 87th Avenue & Southwest 24th Street, Miami, FL",@"", @"",@"", @"",@"", @"", nil];
    }
    return self.busStops;
}

-(NSArray *)busStops{
    if (!_busStops){
        _busStops = [[NSArray alloc] initWithObjects:
                         @"FIU Main Campus, University Park, FL",
                         @"SW 24 St & 88 Ave, Westchester, FL",
                         @"Southwest 87th Avenue & Southwest 24th Street, Miami, FL",
                         @"SW 82 Ave & 24 St, Westchester, FL",
                         @"Southwest 8th Street & Southwest 87th Avenue, Miami, FL",
                         @"Southwest 8th Street & Southwest 57th Avenue, Miami, FL",
                         @"Southwest 8th Street & Southwest 42nd Avenue, Miami, FL",
                         @"Southwest 8th Street & Southwest 27th Avenue, Miami, FL",
                         @"Southwest 8th Street & Southwest 12th Avenue, Miami, FL",
                         @"Brickell STA@SW 1 Av (West Side), Miami, FL ",
                         @"NE 1 a/NE 4 S - (Miami Dade College), Miami, FL",
                         nil];
    }
    NSLog(@"Initializing busStops with element count: %lu", [_busStops count]);
    return _busStops;
}
*/
-(NSString *)routeId{
    if (!_routeId) {
        _routeId = @"";
    }
    return _routeId;
}

-(NSString *)busId{
    if (!_busId) {
        _busId = @"";
    }
    return _busId;
}

-(NSString *)position{
    if (!_position) {
        _position = @"";
    }
    return _position;
}

-(NSString *)time{
    if (!_time) {
        _time = @"";
    }
    return _time;
}

-(NSString *)heading{
    if (!_heading) {
        _heading = @"";
    }
    return _heading;
}

-(BOOL)hasLoggedIn{
    if (!_hasLoggedIn) {
        _hasLoggedIn = false;
    }
    return _hasLoggedIn;
}
@end
