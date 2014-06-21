//
//  ViewController.h
//  libPhoneNumber
//
//  Created by ADMIN on 6/20/14.
//  Copyright (c) 2014 NHN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"

@interface ViewController : UIViewController  <CountryPickerDelegate, UITextFieldDelegate>
{
    NSString *_countryName;
    NSString *_countryCode;
}

@property (nonatomic,retain) IBOutlet UITextField *tfPhoneNumber;
@property (nonatomic,retain) IBOutlet CountryPicker *countryPicker;

-(IBAction)ValidCheck:(id)sender;

@end
