//
//  NSString+MDSApplicationSpecific.m
//  MDS
//
//  Created by Franklin Abodo on 7/27/14.
//  Copyright (c) 2014 Cranking Software. All rights reserved.
//

#import "NSString+MDSApplicationSpecific.h"

@implementation NSString (MDSApplicationSpecific)
-(NSString *)mds_stringWithEncoding:(NSStringEncoding)encoding
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes (NULL, (CFStringRef)self, NULL, (CFStringRef)@";/?:@&=$+{}<>,", CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end
