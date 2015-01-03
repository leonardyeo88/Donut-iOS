//
//  FriendViewController.m
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "FriendViewController.h"
#import "Friend.h"
#import "FriendCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"


@interface FriendViewController ()

@end

@implementation FriendViewController
@synthesize json, friendsArray;

#define JSON_GETFRIENDS_URL @"http://vueartiste.com/donutios/userFriends.php"

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorStyle:)]) { [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; }
    
    [SVProgressHUD showWithStatus:@"Doing Stuff"];
    [self retrieveData];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return friendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    
    FriendCell *cell = (FriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    //retrieve current eventObject for use with this indexpath.row
    Friend *currentFriend = [friendsArray objectAtIndex:indexPath.row];
    
    cell.friendLabel.text = currentFriend.friendName;
    cell.eventNameLabel.text = currentFriend.eventName;
    cell.dateLabel.text = currentFriend.eventDate;
    cell.startTimeLabel.text = currentFriend.eventStartTime;
    cell.endTimeLabel.text = currentFriend.eventEndTime;
    
    cell.imageLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.imageLabel.layer.shadowOffset = CGSizeMake(1, 1);
    cell.imageLabel.layer.shadowRadius = 2.0f;
    cell.imageLabel.layer.shadowOpacity = 0.80f;
    cell.imageLabel.layer.shadowPath = [[UIBezierPath bezierPathWithRect:cell.imageLabel.layer.bounds] CGPath];
    cell.imageLabel.clipsToBounds = NO;
    cell.imageLabel.layer.shouldRasterize = YES;
    
    return cell;
}

-(void) retrieveData
{
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [fetchDefaults objectForKey:@"userid"];
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@", userID];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:JSON_GETFRIENDS_URL];
    
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
        friendsArray = [[NSMutableArray alloc] init];
    
        for (int i=0; i<json.count; i++) {
        //create event object
        NSString *friendName = [[json objectAtIndex:i] objectForKey:@"user_name"];
        NSString *eventName = [[json objectAtIndex:i] objectForKey:@"event_name"];
        NSString *eventDate = [[json objectAtIndex:i] objectForKey:@"event_date"];
        NSString *eventStartTime = [[json objectAtIndex:i] objectForKey:@"event_start_time"];
        NSString *eventEndTime = [[json objectAtIndex:i] objectForKey:@"event_end_time"];
            
            NSLog(@"friend name: %@",friendName);

        Friend *myFriend = [[Friend alloc] initWithFriendName:friendName andEventName:eventName andEventDate:eventDate andEventStartTime:eventStartTime andEventEndTime:eventEndTime];
        
        //add event object to event array
        [friendsArray addObject:myFriend];
        
        }
        self.friendsArray = friendsArray;
        [self.tableView reloadData];
        
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
