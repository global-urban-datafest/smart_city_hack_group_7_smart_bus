//
//  LoginViewController.h
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/8/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import "SBMViewController.h"

@interface LoginViewController : SBMViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *busIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *routeIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *headingTextField;

@end
