//
//  NSManagedObject+NLCoreData_ObjectiveRecord.m
//  Pods
//
//  Created by Kevin Renskers on 28-01-14.
//

#import "NSManagedObject+NLCoreData_ObjectiveRecord.h"
#import "ObjectiveSugar.h"


@implementation NSObject(null)

- (BOOL)exists {
    return self && self != [NSNull null];
}

@end


@implementation NSManagedObject (NLCoreData_ObjectiveRecord)

#pragma mark - Finders

+ (NSArray *)allInContext:(NSManagedObjectContext *)context {
    return [self allInContext:context order:nil];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context order:(id)order {
    return [self fetchWithCondition:nil inContext:context withOrder:order fetchLimit:nil];
}

+ (instancetype)findOrCreate:(NSDictionary *)properties inContext:(NSManagedObjectContext *)context {
    NSManagedObject *existing = [self where:properties inContext:context].first;
    return existing ?: [self create:properties inContext:context];
}

+ (instancetype)find:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context {
    return [self where:attributes inContext:context limit:@1].first;
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context {
    return [self where:condition inContext:context order:nil limit:nil];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order {
    return [self where:condition inContext:context order:order limit:nil];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context limit:(NSNumber *)limit {
    return [self where:condition inContext:context order:nil limit:limit];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order limit:(NSNumber *)limit {
    return [self fetchWithCondition:condition inContext:context withOrder:order fetchLimit:limit];
}

#pragma mark - Aggregation

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context {
    return [self countInContext:context predicate:nil];
}

+ (NSUInteger)countWhere:(id)condition inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [self predicateFromObject:condition];
    return [self countInContext:context predicate:predicate];
}

#pragma mark - Creation / Deletion

+ (id)createInContext:(NSManagedObjectContext *)context {
    NSManagedObject *newEntity = [self insertInContext:context];
    return newEntity;
}

+ (id)create:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context {
    unless([attributes exists]) return nil;

    NSManagedObject *newEntity = [self insertInContext:context];
    [newEntity populateWithDictionary:attributes];

    return newEntity;
}

- (void)update:(NSDictionary *)attributes {
    unless([attributes exists]) return;
    [self populateWithDictionary:attributes];
}

#pragma mark - Private

+ (NSPredicate *)predicateFromDictionary:(NSDictionary *)dict {
    NSArray *subpredicates = [dict map:^(id key, id value) {
        return [NSPredicate predicateWithFormat:@"%K == %@", key, value];
    }];

    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

+ (NSPredicate *)predicateFromObject:(id)condition {

    if ([condition isKindOfClass:[NSPredicate class]])
        return condition;

    else if ([condition isKindOfClass:[NSString class]])
        return [NSPredicate predicateWithFormat:condition];

    else if ([condition isKindOfClass:[NSDictionary class]])
        return [self predicateFromDictionary:condition];

    return nil;
}

+ (NSSortDescriptor *)sortDescriptorFromDictionary:(NSDictionary *)dict {
    BOOL isAscending = ![[dict.allValues.first uppercaseString] isEqualToString:@"DESC"];
    return [NSSortDescriptor sortDescriptorWithKey:dict.allKeys.first
                                         ascending:isAscending];
}

+ (NSSortDescriptor *)sortDescriptorFromObject:(id)order {
    if ([order isKindOfClass:[NSSortDescriptor class]])
        return order;

    else if ([order isKindOfClass:[NSString class]])
        return [NSSortDescriptor sortDescriptorWithKey:order ascending:YES];

    else if ([order isKindOfClass:[NSDictionary class]])
        return [self sortDescriptorFromDictionary:order];

    return nil;
}

+ (NSArray *)sortDescriptorsFromObject:(id)order {
    if ([order isKindOfClass:[NSArray class]])
        return [order map:^id (id object) {
            return [self sortDescriptorFromObject:object];
        }];

    else
        return @[[self sortDescriptorFromObject:order]];
}

+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName]
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}

+ (NSArray *)fetchWithCondition:(id)condition
                      inContext:(NSManagedObjectContext *)context
                      withOrder:(id)order
                     fetchLimit:(NSNumber *)fetchLimit {

    NSFetchRequest *request = [self createFetchRequestInContext:context];

    if (condition)
        [request setPredicate:[self predicateFromObject:condition]];

    if (order)
        [request setSortDescriptors:[self sortDescriptorsFromObject:order]];

    if (fetchLimit)
        [request setFetchLimit:[fetchLimit integerValue]];

    return [context executeFetchRequest:request error:nil];
}

@end
