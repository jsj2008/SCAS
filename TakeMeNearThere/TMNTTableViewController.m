//
//  TMNTTableViewController.m
//  TakeMeNearThere
//
//  Created by Nathan Levine on 3/22/13.
//  Copyright (c) 2013 Heroes in a Half Shell. All rights reserved.
//

#import "TMNTTableViewController.h"
#import "TMNTAppDelegate.h"
#import <CoreData/CoreData.h>
#import "TMNTSecondVC.h"


@interface TMNTTableViewController ()
{
    TMNTSecondVC *secondViewController;
    NSString *placeName;
}


@end

@implementation TMNTTableViewController
@synthesize historyPersistedArray1, myManagedObjectContext1, placeVisted, userLocationHistory;

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
    NSLog(@"HEY!!!!!!!! %@", historyPersistedArray1);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if (historyPersistedArray1 == nil)
    {
        return 0;
    }
    else
    {
        return historyPersistedArray1.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifierRolodex"];
    
    // Configure the cell...
    PlaceVisited *place = [historyPersistedArray1 objectAtIndex:[indexPath row]];
    placeName = place.title;
//    NSLog(@"%@",placeName);
//    placeTitleLabel.text = placeName;
    
    UIView * titleViewToLabel = [customCell viewWithTag:100];
    UILabel *titleLabel = (UILabel *) titleViewToLabel;
    titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    titleLabel.text = placeName;
    
    NSString *placeAddress = place.address;
    UIView * addressViewToLabel = [customCell viewWithTag:110];
    UILabel *addressLabel = (UILabel *) addressViewToLabel;
    addressLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
    addressLabel.text = placeAddress;
    
    //phoneStringTest = [[historyPersistedArray1 objectAtIndex:[indexPath row]]title];
    //phoneStringTest= placeName;
    
    return customCell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

-(NSArray*)getPersistedData
{
    //setting up the fetch
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PlaceVisited"
                                                         inManagedObjectContext:self.myManagedObjectContext1];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSFetchedResultsController *fetchResultsController;
    
    //manipulate the fetch
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: nil];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name contains[c] '%@'", myCustomSearchText]];
    NSError *sadnessError;
    //
    //    if ([myCustomSearchText isEqualToString:@""])
    //    {
    //        predicate = nil;
    //    }
    //
    //actually setting up the fetch
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entityDescription];
    //[fetchRequest setPredicate:predicate];
    fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:myManagedObjectContext1
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    [fetchResultsController performFetch:&sadnessError];
    
    return fetchResultsController.fetchedObjects;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        
        placeVisted = [historyPersistedArray1 objectAtIndex:[indexPath row]];
        
        [self.myManagedObjectContext1 deleteObject:placeVisted];
        
       // [self.myManagedObjectContext deleteObject:placeVisited1];
        NSError *error;
        if (![myManagedObjectContext1 save:&error])
        {
            NSLog(@"failed to save error: %@", [error userInfo]);
        }
        historyPersistedArray1 = [self getPersistedData];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView reloadData];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"historyToSecondDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PlaceVisited *place = [historyPersistedArray1 objectAtIndex:[indexPath row]];
        [[segue destinationViewController] setPlaceVisitedSecondDetail:place];
        [[segue destinationViewController] setUserLocation:userLocationHistory];
    }
}
@end
