//
//  NSString+NSString_Encode.h
//  MDS
//
//  Created by Franklin Abodo on 7/27/14.
//  Copyright (c) 2014 Cranking Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MDSApplicationSpecific)
-(NSString *)mds_stringWithEncoding:(NSStringEncoding)encoding;
@end
