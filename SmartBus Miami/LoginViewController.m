//
//  LoginViewController.m
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/8/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import "LoginViewController.h"

#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]
@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) id activeTextField;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@end

@implementation LoginViewController

- (IBAction)submitButton:(UIButton *)sender {
    NSLog(@"submitButtonTapped");
    [self startSession];
    
    if (!self.bus) {
        self.bus = [[Metrobus alloc] init];
        [self.bus setBusId:self.busIdTextField.text];
        [self.bus setRouteId:self.routeIdTextField.text];
        [self.bus setPosition:@"0"];
        [self.bus setHeading:self.headingTextField.text];
        NSLog(@"Login view controller bus initialized to %@ at %@",[self.bus description], TimeStamp);
    }
    
    NSString *urlString = [self constructUrlString];
    NSLog(@"urlString: %@",urlString);
    
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
    
    [self performSegueWithIdentifier:@"fromLvcToSpvc" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue from %@ to %@ at %@",[self class], [sender class], TimeStamp);
    if ([[segue identifier]isEqualToString:@"fromLvcToSpvc"]) {
        SBMViewController *destinationViewController = [segue destinationViewController];
        [destinationViewController setBus:self.bus];
        NSLog(@"setting destination view constroller bus to %@",[self.bus class]);
    }
}

-(void)hideKeyboard {
    NSLog(@"hideKeyboard called");
    [_activeTextField resignFirstResponder];
    _tapGestureRecognizer.enabled = NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _tapGestureRecognizer.enabled = YES;
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _activeTextField = textField;
    NSLog(@"textFieldDidBeginEditing");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    return YES;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.busIdTextField setDelegate:self];
    [self.routeIdTextField setDelegate:self];
    [self.headingTextField setDelegate:self];
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    _tapGestureRecognizer.enabled = NO;
    
    [self.backgroundView addGestureRecognizer:self.tapGestureRecognizer];
    NSLog(@"LoginViewController viewDidLoad.\n TapGestureRecognizer = %@", _tapGestureRecognizer.description);
}
@end
