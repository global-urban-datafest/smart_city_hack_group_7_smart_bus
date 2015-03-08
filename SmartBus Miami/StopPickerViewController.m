//
//  StopPickerViewController.m
//  SmartBus Miami
//
//  Created by Franklin Abodo on 3/8/15.
//  Copyright (c) 2015 Franklin Abodo. All rights reserved.
//

#import "StopPickerViewController.h"

@interface StopPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *stopPicker;
- (IBAction)signalStopButton:(UIButton *)sender;

@end

@implementation StopPickerViewController

- (IBAction)submitButton:(UIButton *)sender {
    NSLog(@"submitButtonTapped");
    [self startSession];
    
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
    
    [self performSegueWithIdentifier:@"fromSpvcToLvc" sender:self];
}
#pragma mark - Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSLog(@"Returning numberOfComponentsInPickerView: %@",[NSString stringWithFormat:@"%d",2]);
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    NSLog(@"Returning pickerView:numberOfRowsInComponent: %@",[NSString stringWithFormat:@"%lu",[[self.bus busStops] count]]);
    return [[self.bus busStops] count];
}
#pragma mark - Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    
    //NSLog(@"Returning pickerView:titleForRow:forComponent: %@",[NSString stringWithFormat:@"%@",[self.bus.busStops objectAtIndex:row]]);
    return [[[NSString stringWithFormat:@"%lu",(row + 1)] stringByAppendingString:@" | "] stringByAppendingString:[self.bus.busStops objectAtIndex:row]];
}
#pragma mark - View Transition Methods
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.stopPicker setDelegate:self];
    [self.stopPicker setDataSource:self];
    [self.stopPicker setShowsSelectionIndicator:YES];
    //[self.stopPicker set]
}
- (IBAction)signalStopButton:(UIButton *)sender {
    
    NSInteger selectedRow = [self.stopPicker selectedRowInComponent:0] + 1;
    
    if (selectedRow <= [self.bus.busStops indexOfObject:[self.bus.busStops lastObject]]) {
        [self.stopPicker selectRow:selectedRow inComponent:0 animated:YES];
        [self.bus setPosition:[NSString stringWithFormat:@"%lu",selectedRow]];
        
        [self startSession];
        
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
    }
}
@end
