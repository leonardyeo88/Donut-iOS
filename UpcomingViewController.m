//
//  UpcomingViewController.m
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "UpcomingViewController.h"
#import "Upcoming.h"
#import "UpcomingCell.h"

@interface UpcomingViewController ()

@end

@implementation UpcomingViewController
@synthesize json, upcomingArray, upcomingTableView;

#define JSON_GETCOMPLETED_URL @"http://vueartiste.com/donutios/checkCompleted.php"

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
    
    if ([self.upcomingTableView respondsToSelector:@selector(setSeparatorStyle:)]) { [self.upcomingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; }
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"upcomingbackground.png"]];
    [tempImageView setFrame:self.upcomingTableView.frame];
    
    self.upcomingTableView.backgroundView = tempImageView;
    
    [self retrieveData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return upcomingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];*/
    
    // Configure the cell...
    
    static NSString *CellIdentifier = @"UpcomingCell";
    
    UpcomingCell *cell = (UpcomingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UpcomingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    //retrieve current eventObject for use with this indexpath.row
    Upcoming *currentUpcoming = [upcomingArray objectAtIndex:indexPath.row];
    
    cell.eventNameLabel.text = currentUpcoming.eventName;
    cell.eventDateLabel.text = currentUpcoming.eventDate;
    
    
    return cell;
}

-(void) retrieveData
{
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [fetchDefaults objectForKey:@"userid"];
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@", userID];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:JSON_GETCOMPLETED_URL];
    
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
    //NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        //NSData *data = [NSData dataWithContentsOfURL:url];
        json = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        
        //set up events array
        upcomingArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<json.count; i++) {
            //create event object
            NSString *eventName = [[json objectAtIndex:i] objectForKey:@"event_name"];
            NSString *eventDate = [[json objectAtIndex:i] objectForKey:@"event_date"];
            
            NSLog(@"event name: %@",eventName);
            
            Upcoming *myUpcoming = [[Upcoming alloc] initWithEventName:eventName andEventDate:eventDate];
            
            //add event object to event array
            [upcomingArray addObject:myUpcoming];
            
        }
        self.upcomingArray = upcomingArray;
        [self.upcomingTableView reloadData];
        
    }else {
        //if (error) NSLog(@"Error: %@", error);
        [self alertStatus:@"Connection Failed" :@"" :0];
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
