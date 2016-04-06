//
//  Message+CoreDataProperties.m
//  
//
//  Created by Vitaliy Rusinov on 4/6/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message+CoreDataProperties.h"

@implementation Message (CoreDataProperties)

@dynamic body;
@dynamic date;
@dynamic guid;
@dynamic title;
@dynamic userId;
@dynamic readState;

@end
