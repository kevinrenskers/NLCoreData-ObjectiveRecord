//
//  NSManagedObject+NLCoreData_ObjectiveRecord.h
//  Pods
//
//  Created by Kevin Renskers on 28-01-14.
//

#import <CoreData/CoreData.h>
#import <NLCoreData/NLCoreData.h>


@interface NSManagedObject (NLCoreData_ObjectiveRecord)

#pragma mark - Finders

+ (NSArray *)allInContext:(NSManagedObjectContext *)context;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context order:(id)order;
+ (instancetype)findOrCreate:(NSDictionary *)properties inContext:(NSManagedObjectContext *)context;
+ (instancetype)find:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context limit:(NSNumber *)limit;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order limit:(NSNumber *)limit;

#pragma mark - Aggregation

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context;
+ (NSUInteger)countWhere:(id)condition inContext:(NSManagedObjectContext *)context;

#pragma mark - Creation / Deletion

+ (id)createInContext:(NSManagedObjectContext *)context;
+ (id)create:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context;
- (void)update:(NSDictionary *)attributes;

@end
