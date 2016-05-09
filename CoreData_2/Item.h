//
//  Item.h
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (NSString *)entityName;

+ (Item *)insertItemWithTitle:(NSString *)title
                             parent:(Item *)parent
             inManagedObjectContext:(NSManagedObjectContext *)context;

- (NSFetchedResultsController *)childrenFetchedResultsController;

@end

NS_ASSUME_NONNULL_END

#import "Item+CoreDataProperties.h"
