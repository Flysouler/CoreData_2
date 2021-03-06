//
//  Store.m
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "Store.h"

#import "Item.h"

#import <CoreData/CoreData.h>

@implementation Store

- (Item *)rootItem
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[Item entityName]];
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", nil];
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:NULL];
    Item *rootItem = [objects lastObject];
    if (rootItem == nil) {
        rootItem = [Item insertItemWithTitle:nil
                                      parent:nil
                      inManagedObjectContext:self.managedObjectContext];
    }
    
    return rootItem;
}

@end
