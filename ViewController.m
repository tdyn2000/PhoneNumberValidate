//
//  ViewController.m
//  libPhoneNumber
//
//  Created by ADMIN on 6/20/14.
//  Copyright (c) 2014 NHN. All rights reserved.
//

#import "ViewController.h"
#import "NBPhoneNumberUtil.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tfPhoneNumber;
@synthesize countryPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    [countryPicker setSelectedCountryCode:_countryCode animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([tfPhoneNumber isFirstResponder] && [touch view] != tfPhoneNumber) {
        [tfPhoneNumber resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    _countryName = name;
    _countryCode = code;
    NSLog(@"Name: %@ Code: %@",name,code);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [tfPhoneNumber resignFirstResponder];
}

-(IBAction)ValidCheck:(id)sender{
    NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
    NSError *aError = nil;
    NSLog(@"Phone number: %@",tfPhoneNumber.text);
    NBPhoneNumber *myNumber = [phoneUtil parse:tfPhoneNumber.text
                                 defaultRegion:_countryCode error:&aError];
    NSString *number;
    BOOL isError = NO;
    NSString *msgContent =  @"";
    
    if (aError == nil) {
        if([phoneUtil isValidNumber:myNumber] ){
            number = [phoneUtil format:myNumber numberFormat:NBEPhoneNumberFormatINTERNATIONAL                                         error:&aError];
        }
        else{
            isError = YES;
        }
    };
    
    if(aError != nil){
        isError = YES;
    };
    
    if(!isError){
        
        if ([tfPhoneNumber isFirstResponder]) {
            [tfPhoneNumber resignFirstResponder];
        }
        
        msgContent = [NSString stringWithFormat:@"%@\nRegistered successfully\nThank you!",number];
        
    }else{
         msgContent = @"Invalid phone number.";
    }
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                      message:msgContent
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
