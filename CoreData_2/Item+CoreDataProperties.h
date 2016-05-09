//
//  Item+CoreDataProperties.h
//  CoreData_2
//
//  Created by guoshuai on 16/5/6.
//  Copyright © 2016年 swiftTest. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *order;
@property (nullable, nonatomic, retain) Item *parent;
@property (nullable, nonatomic, retain) NSSet<Item *> *children;

@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(Item *)value;
- (void)removeChildrenObject:(Item *)value;
- (void)addChildren:(NSSet<Item *> *)values;
- (void)removeChildren:(NSSet<Item *> *)values;

@end

NS_ASSUME_NONNULL_END
