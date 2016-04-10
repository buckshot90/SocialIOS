//
//  User+CoreDataProperties.h
//  
//
//  Created by Vitaliy Rusinov on 4/10/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *guid;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneMobile;
@property (nullable, nonatomic, retain) NSString *nickName;
@property (nullable, nonatomic, retain) NSNumber *online;
@property (nullable, nonatomic, retain) NSNumber *onlineMobile;
@property (nullable, nonatomic, retain) NSString *photoLow;
@property (nullable, nonatomic, retain) NSString *photoOrign;
@property (nullable, nonatomic, retain) NSString *photoMiddle;

@end

NS_ASSUME_NONNULL_END
