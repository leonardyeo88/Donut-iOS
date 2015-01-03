//
//  SettingsViewController.m
//  Donut
//
//  Created by Leonard Yeo on 21/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize feedbackText;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    //NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    //[standardUserDefaults setBool:NO forKey:@"userid"];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (IBAction)sendFeebackClicked:(id) sender
{
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [fetchDefaults objectForKey:@"userid"];
    
    
    NSInteger success = 0;
    NSInteger unsuccessful = 0;
    @try {
        
        if([[self.feedbackText text] isEqualToString:@""]) {
        
            [self alertStatus:@"Please enter the feedback" :@"Sending of feedback  failed!" :0];
            
        }
        
        else{
            
        NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&feedback=%@",userID,[self.feedbackText text]];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://vueartiste.com/donutios/addFeedback.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
            
            success = [jsonData[@"success"] integerValue];
            unsuccessful = [jsonData[@"unsuccessfull"] integerValue];
            
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                NSLog(@"Feedback sent!!!");
                [self alertStatus:@"":@"Feedback sent!!!" :0];
            } else if(unsuccessful == 1) {
                
                //NSString *error_msg = (NSString *) jsonData[@"error"];
                [self alertStatus:@"":@"Feedback not sent" :0];
            }
            
        } else {
            //if (error) NSLog(@"Error: %@", error);
            [self alertStatus:@"Connection Failed" :@"Sending of feedback Failed!" :0];
        }
        
    }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sending of feedback failed." :@"Error!" :0];
    }


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([feedbackText isFirstResponder] && [touch view] != feedbackText) {
        [feedbackText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                                    message:msg
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}
@end
