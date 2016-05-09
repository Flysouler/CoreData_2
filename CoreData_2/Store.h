//
//  Store.h
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Item, NSManagedObjectContext;

@interface Store : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


- (Item *)rootItem;

@end
