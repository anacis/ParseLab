//
//  ViewController.m
//  ParseLab
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)signUp:(id)sender {
    [self registerUser];
}

- (IBAction)login:(id)sender {
    [self loginUser];
}

- (void)registerUser {
    //check all fields are entered
    if ([self.usernameTextField.text isEqual:@""]
        || [self.passwordTextField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Data"
               message:@"Please enter a username and password"
        preferredStyle:(UIAlertControllerStyleAlert)];
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                   message:@"Failed to register user"
            preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
            }];
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}


@end
