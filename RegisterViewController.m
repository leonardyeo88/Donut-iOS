//
//  RegisterViewController.m
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize name, email, password, number, picker, school, schoolArray;

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
    
    
    self.schoolArray = [[NSMutableArray alloc]initWithObjects:@"RJ", @"HCI", @"RI", @"RGS", @"RGS", @"Public", @"RP", @"NYP", @"NP", @"SP", @"TP", @"SIT", @"NUS", @"NTU", @"SMU", @"SUTD", @"uniSIM",nil];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [picker setDataSource: self];
    [picker setDelegate: self];
    picker.showsSelectionIndicator = YES;
    self.school.inputView = picker;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (BOOL) textFieldShouldBeginEditing:(UITextView *)school
{
    picker.frame = CGRectMake(0, 500, picker.frame.size.width,    picker.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.50];
    [UIView setAnimationDelegate:self];
    picker.frame = CGRectMake(0, 200, picker.frame.size.width, picker.frame.size.height);
    [self.view addSubview:picker];
    [UIView commitAnimations];
    return NO;
}*/

- (IBAction)registerClicked:(id)sender {
    
    NSInteger success = 0;
    //NSInteger userID = 0;
    @try {
        
        if([[self.name text] isEqualToString:@""] || [[self.email text] isEqualToString:@""] ) {
            
            [self alertStatus:@"Please enter all the fields" :@"Register Failed!" :0];
            
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"name=%@&email=%@&password=%@&school=%@&mobile=%@",[self.name text],[self.email text], [self.password text], [self.school text], [self.number text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://vueartiste.com/donut/register.php"];
            
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
                //userID = [jsonData[@"userID"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Register SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Register Failed!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Register Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Register Failed." :@"Error!" :0];
    }
    if (success) {
        // To Save A String
        //NSString *userid = [NSString stringWithFormat: @"%d", (int)userID];
        //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //[defaults setObject:userid forKey:@"userid"];
        [self performSegueWithIdentifier:@"register_success" sender:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([name isFirstResponder] && [touch view] != name) {
        [name resignFirstResponder];
    }else if([email isFirstResponder] && [touch view] != email){
        [email resignFirstResponder];
    }else if([password isFirstResponder] && [touch view] != password){
        [password resignFirstResponder];
    }else if([number isFirstResponder] && [touch view] != number){
        [number resignFirstResponder];
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

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return schoolArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.schoolArray objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    self.school.text = [self.schoolArray objectAtIndex:row];
    [self.school resignFirstResponder];
}

@end
