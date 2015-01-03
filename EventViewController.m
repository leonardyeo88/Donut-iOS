//
//  EventViewController.m
//  Donut
//
//  Created by Leonard Yeo on 11/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "EventViewController.h"
#import "Event.h"
#import "EventCell.h"
#import <QuartzCore/QuartzCore.h>
#import "EventDetailViewController.h"
#import "SVProgressHUD.h"

#define JSON_AllEVENTS_URL @"http://vueartiste.com/donutios/allEvents.php"

@interface EventViewController ()

@end

@implementation EventViewController
@synthesize json, eventsArray, activityIndicatorView, searchResults, searchBar;

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
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorStyle:)]) {
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    [SVProgressHUD showWithStatus:@"Doing Stuff"];
    [self retrieveData];
    [SVProgressHUD dismiss];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[eventsArray count]];
    
    
    
    
    /*UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.myTableView addSubview:refreshControl];*/
}

- (void)refresh:(id)sender
{
    // do your refresh here and reload the tablview
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
        
    } else {
    return eventsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];*/
    
    // Configure the cell...
    
    static NSString *CellIdentifier = @"EventCell";
    
    EventCell *cell = (EventCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //retrieve current eventObject for use with this indexpath.row
    //Event *currentEvent = [eventsArray objectAtIndex:indexPath.row];
    //Event *currentEvent = [[Event alloc]init];
    
    Event *currentEvent = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        currentEvent = [searchResults objectAtIndex:indexPath.row];
    } else {
        currentEvent = [eventsArray objectAtIndex:indexPath.row];
    }
    
    
    cell.titleLabel.text = currentEvent.eventName;
    cell.dateLabel.text = currentEvent.eventDate;
    cell.startTimeLabel.text = currentEvent.eventStartTime;
    cell.endTimeLabel.text = currentEvent.eventEndTime;
    
    cell.imageLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.imageLabel.layer.shadowOffset = CGSizeMake(1, 1);
    cell.imageLabel.layer.shadowRadius = 2.0f;
    cell.imageLabel.layer.shadowOpacity = 0.80f;
    cell.imageLabel.layer.shadowPath = [[UIBezierPath bezierPathWithRect:cell.imageLabel.layer.bounds] CGPath];
    cell.imageLabel.clipsToBounds = NO;
    cell.imageLabel.layer.shouldRasterize = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 202;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.eventName contains[c] %@", searchText];
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.eventName LIKE[c] %@", searchText];
    searchResults = [NSMutableArray arrayWithArray:[eventsArray filteredArrayUsingPredicate:resultPredicate]];
    NSLog(@"search results %lu",(unsigned long)searchResults.count);
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

-(void) retrieveData
{
    NSURL *url = [NSURL URLWithString:JSON_AllEVENTS_URL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //set up events array
    eventsArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<json.count; i++) {
        //create event object
        NSString *eName = [[json objectAtIndex:i] objectForKey:@"event_name"];
        NSString *eVenue = [[json objectAtIndex:i] objectForKey:@"event_venue"];
        NSString *eID = [[json objectAtIndex:i] objectForKey:@"event_id"];
        NSString *eDate = [[json objectAtIndex:i] objectForKey:@"event_date"];
        NSString *eStartTime = [[json objectAtIndex:i] objectForKey:@"event_start_time"];
        NSString *eEndTime = [[json objectAtIndex:i] objectForKey:@"event_end_time"];
        NSString *ePax = [[json objectAtIndex:i] objectForKey:@"event_pax"];
        NSString *eDescription = [[json objectAtIndex:i] objectForKey:@"event_description"];
        NSString *eOrgUrl = [[json objectAtIndex:i] objectForKey:@"org_url"];
        
        Event *myEvent = [[Event alloc] initWithEventName:eName andEventVenue:eVenue andEventID: eID andEventDate:eDate andEventStartTime:eStartTime andEventEndTime:eEndTime andEventPax:ePax andEventDescription:eDescription andEventOrgURL:eOrgUrl];
        
        //add event object to event array
        [eventsArray addObject:myEvent];
        
    }
    self.eventsArray = eventsArray;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"eventDetail" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"eventDetail"]) {
        
        NSIndexPath *indexPath = nil;
        Event *event = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            event = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            event = [eventsArray objectAtIndex:indexPath.row];
        }
        
        
        //NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        EventDetailViewController *destViewController = segue.destinationViewController;
        
        Event *currentEvent = [eventsArray objectAtIndex:indexPath.row];
        destViewController.etitleDetail = currentEvent.eventName;
        destViewController.edateDetail = currentEvent.eventDate;
        destViewController.evenueDetail = currentEvent.eventVenue;
        destViewController.edescriptionDetail = currentEvent.eventDescription;
        destViewController.estartTimeDetail = currentEvent.eventStartTime;
        destViewController.eendTimeDetail = currentEvent.eventEndTime;
        destViewController.eIDDetail = currentEvent.eventID;
    }
}

/*#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}*/

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
