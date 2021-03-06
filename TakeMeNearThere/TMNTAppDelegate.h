//
//  TMNTAppDelegate.h
//  TakeMeNearThere
//
//  Created by Nathan Levine on 3/5/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TMNTAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSManagedObjectModel *myManagedObjectModel;
    NSPersistentStoreCoordinator *myPersistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) NSManagedObjectContext *myManagedObjectContext;

@end
