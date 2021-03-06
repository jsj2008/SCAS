//
//  TMNTTableViewController.h
//  TakeMeNearThere
//
//  Created by Nathan Levine on 3/22/13.
//  Copyright (c) 2013 Heroes in a Half Shell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceVisited.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface TMNTTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{


}
@property (strong, nonatomic) NSArray *historyPersistedArray1;
@property NSManagedObjectContext *myManagedObjectContext1;
@property PlaceVisited *placeVisted;
@property (assign, nonatomic) CLLocation *userLocationHistory;

@end
