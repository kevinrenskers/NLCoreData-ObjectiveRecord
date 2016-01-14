# NLCoreData-ObjectiveRecord
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

Adding ObjectiveRecord syntax on top of NLCoreData.


## What's this?
[ObjectiveRecord](https://github.com/mneorr/ObjectiveRecord) has a really nice syntax for working with Core Data:

```
Person *john = [Person create:@{ 
    @"name": @"John",
    @"age": @12, 
    @"member": @NO 
}];

NSArray *people = [Person where:@{ 
    @"age": @18,
    @"member": @YES,
    @"state": @"NY"
}];
```

Sadly, it doesn't offer any support for background contexts or nested (asynchronous) saving.

[NLCoreData](https://github.com/jksk/NLCoreData) on the other hand has a solid feature set for working with Core Data, but is missing this nice way of searching for data, it expects you to write the predicate.

NLCoreData-ObjectiveRecord is a simple category, adding the ObjectiveRecord syntax on top of NLCoreData.


## Credits
All the credits go to [ObjectiveRecord](https://github.com/mneorr/ObjectiveRecord) and [NLCoreData](https://github.com/jksk/NLCoreData).
