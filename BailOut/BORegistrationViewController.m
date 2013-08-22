//
//  BORegistrationViewController.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BORegistrationViewController.h"
#import "BOAPIUserService.h"

@interface BORegistrationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *countryCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation BORegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Register", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self _endLoading];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    ABDispatchMain(^{
        [self.countryCodeTextField becomeFirstResponder];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self _attemptRegister];
    return YES;
}

#pragma mark - Override

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

- (IBAction)_handleRegisterTapped:(id)sender
{
    [self _attemptRegister];
}

#pragma mark - Register

- (NSString *)_getPhoneNumberFromTextFields
{
    NSString *code = [self.countryCodeTextField.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString *phoneNumber = [self.phoneNumberTextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *full = [NSString stringWithFormat:@"%@%@",code,phoneNumber];
    return full;
}

- (void)_attemptRegister
{
    [self _startLoading];
    
    NSString *phoneNumber = [self _getPhoneNumberFromTextFields];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[BOAPIUserService sharedInstance] registerPhoneNumber:phoneNumber onCompletion:^(BOOL success, NSError *error){
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (success) {
            [self performSegueWithIdentifier:@"Verify Segue" sender:self];
        } else {
            [self _endLoading];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Invalid Phone Number", nil)
                                        message:NSLocalizedString(@"Please check the phone number you entered and try again. Don't forget the leading country code!", nil)
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                              otherButtonTitles:nil, nil] show];
        }
    }];
}

#pragma mark - Loading

- (void)_startLoading
{
    [self.spinner startAnimating];
    self.registerButton.hidden = YES;
}

- (void)_endLoading
{
    [self.spinner stopAnimating];
    self.registerButton.hidden = NO;
}

@end
