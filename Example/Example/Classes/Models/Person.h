//
//  Person.h
//  Example
//
//  Created by Kevin Renskers on 28-01-14.
//  Copyright (c) 2014 Kevin Renskers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * member;

@end
