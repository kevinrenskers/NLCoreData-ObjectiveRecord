//
//  NormalViewController.m
//  Example
//
//  Created by Kevin Renskers on 28-01-14.
//  Copyright (c) 2014 Kevin Renskers. All rights reserved.
//

#import "NormalViewController.h"
#import "Person.h"


@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (IBAction)test {
    Person *john = [Person insertInContext:[NSManagedObjectContext mainContext]];
    john.name = @"John";
    [[NSManagedObjectContext mainContext] save];

    NSArray *people = [Person where:@{
        @"name" : @"John",
    } inContext:[NSManagedObjectContext mainContext]];

    DLog(@"people: %@", people);
}

@end
