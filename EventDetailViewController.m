//
//  EventDetailViewController.m
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController
@synthesize eventTitleLabel, eventDateLabel, eventDescriptionLabel, eventEndTimeLabel, eventStartTimeLabel, eventVenueLabel;
@synthesize etitleDetail, edateDetail, evenueDetail,edescriptionDetail,eendTimeDetail,estartTimeDetail;

@synthesize eIDDetail, eUserIDDetail;

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
    eventTitleLabel.text = etitleDetail;
    eventVenueLabel.text = evenueDetail;
    eventStartTimeLabel.text = estartTimeDetail;
    eventEndTimeLabel.text = eendTimeDetail;
    eventDescriptionLabel.text = edescriptionDetail;
    eventDateLabel.text = edateDetail;
    
    //eventDescriptionLabel.numberOfLines = 0;
    //[eventDescriptionLabel sizeToFit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)volunteerClicked:(id)sender {
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [fetchDefaults objectForKey:@"userid"];
    
    
    NSInteger success = 0;
    NSInteger unsuccessful = 0;
    @try {
        
            NSString *post =[[NSString alloc] initWithFormat:@"event_id=%@&user_id=%@",eIDDetail,userID];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://vueartiste.com/donutios/volunteerEvents.php"];
            
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
                    NSLog(@"Volunteered!!!");
                    [self alertStatus:@"":@"Volunteered!!!" :0];
                } else if(unsuccessful == 1) {
                    
                    //NSString *error_msg = (NSString *) jsonData[@"error"];
                    [self alertStatus:@"":@"Volunteered already!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
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
