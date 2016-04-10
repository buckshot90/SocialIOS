//
//  SOLUserMapperImplementation.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLUserMapperImplementation.h"
#import "SOLUserPlainObject.h"

@implementation SOLUserMapperImplementation

//bdate = "17.9";
//"can_post" = 1;
//"can_see_all_posts" = 1;
//"can_write_private_message" = 1;
//city =         {
//    id = 627;
//    title = Simferopol;
//};
//country =         {
//    id = 1;
//    title = Russia;
//};
//domain = "oksanka_bogdanova";
//"first_name" = Oksana;
//graduation = 2011;
//"has_mobile" = 1;
//"home_phone" = "";
//id = 62077185;
//"last_name" = Bogdanova;
//"last_seen" =         {
//    platform = 2;
//    time = 1460297041;
//};
//lists =         (
//                 4
//                 );
//"mobile_phone" = "+7978-805-61-20";
//nickname = "";
//online = 1;
//"online_app" = 3140623;
//"online_mobile" = 1;
//"photo_100" = "https://pp.vk.me/c630118/v630118185/22c18/NRJD1oyHLb8.jpg";
//"photo_200_orig" = "https://pp.vk.me/c630118/v630118185/22c15/dOAR8_kYDzE.jpg";
//"photo_50" = "https://pp.vk.me/c630118/v630118185/22c19/cwm6DmgkhPw.jpg";
//relation = 0;
//sex = 1;
//status = "";

//@property (nullable, copy, nonatomic, readwrite) NSString *guid;
//@property (nullable, copy, nonatomic, readwrite) NSString *firstName;
//@property (nullable, copy, nonatomic, readwrite) NSString *lastName;
//@property (nullable, copy, nonatomic, readwrite) NSString *nickname;
//@property (nullable, copy, nonatomic, readwrite) NSString *photoLow;
//@property (nullable, copy, nonatomic, readwrite) NSString *photoOrign;
//@property (nullable, copy, nonatomic, readwrite) NSString *photoMiddle;
//@property (nullable, copy, nonatomic, readwrite) NSString *mobilePhone;
//@property (assign, nonatomic, readwrite) BOOL online;
//@property (assign, nonatomic, readwrite) BOOL onlineMobile;


- (SOLUserPlainObject *)objectFromExternalRepresentation:(NSDictionary *)dictionary {
    
    SOLUserPlainObject *plain = [SOLUserPlainObject new];
    if (dictionary) {
        
        id guid = [dictionary objectForKey:@"id"];
        if([guid isKindOfClass:[NSString class]]) {
            
            plain.guid = (NSString *)guid;
        } else if([guid isKindOfClass:[NSNumber class]]) {
            
            plain.guid = ((NSNumber *)guid).stringValue;
        }
        
        id firstNameId = [dictionary objectForKey:@"first_name"];
        if([firstNameId isKindOfClass:[NSString class]]) {
            
            plain.firstName = (NSString *)firstNameId;
        }
        
        id lastNameId = [dictionary objectForKey:@"last_name"];
        if([lastNameId isKindOfClass:[NSString class]]) {
            
            plain.lastName = (NSString *)lastNameId;
        }
        
        id nickNameId = [dictionary objectForKey:@"nickname"];
        if([nickNameId isKindOfClass:[NSString class]]) {
            
            plain.nickName = (NSString *)nickNameId;
        }
        
        id photoLowId = [dictionary objectForKey:@"photo_50"];
        if([photoLowId isKindOfClass:[NSString class]]) {
            
            plain.photoLow = (NSString *)photoLowId;
        }
        
        id photoOrignId = [dictionary objectForKey:@"photo_200_orig"];
        if([photoOrignId isKindOfClass:[NSString class]]) {
            
            plain.photoOrign = (NSString *)photoOrignId;
        }
        
        id photoMiddleId = [dictionary objectForKey:@"photo_100"];
        if([photoMiddleId isKindOfClass:[NSString class]]) {
            
            plain.photoMiddle = (NSString *)photoMiddleId;
        }
        
        id mobilePhoneId = [dictionary objectForKey:@"mobile_phone"];
        if([mobilePhoneId isKindOfClass:[NSString class]]) {
            
            plain.mobilePhone = (NSString *)mobilePhoneId;
        }
        
        id onlineId = [dictionary objectForKey:@"online"];
        if([onlineId isKindOfClass:[NSNumber class]]) {
            
            plain.online = (NSNumber *)onlineId;
        }
        
        id onlineMobileId = [dictionary objectForKey:@"online_mobile"];
        if([onlineMobileId isKindOfClass:[NSNumber class]]) {
            
            plain.onlineMobile = (NSNumber *)onlineMobileId;
        }
    }
    
    return plain;
}

- (NSArray<SOLUserPlainObject *> *)arrayFromExternalRepresentation:(NSArray *)array {
    
    NSMutableArray<SOLUserPlainObject *> *list = [[NSMutableArray<SOLUserPlainObject *> alloc] initWithCapacity:array.count];
    for (NSDictionary *external in array) {
        
        [list addObject:[self objectFromExternalRepresentation:external]];
    }
    
    return list;
}

@end
