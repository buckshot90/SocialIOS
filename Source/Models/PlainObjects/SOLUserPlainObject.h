//
//  SOLUserPlainObject.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/3/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLPlainObject.h"

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

@interface SOLUserPlainObject : NSObject

@property (nullable, copy, nonatomic, readwrite) NSString *guid;
@property (nullable, copy, nonatomic, readwrite) NSString *firstName;
@property (nullable, copy, nonatomic, readwrite) NSString *lastName;
@property (nullable, copy, nonatomic, readwrite) NSString *nickName;
@property (nullable, copy, nonatomic, readwrite) NSString *photoLow;
@property (nullable, copy, nonatomic, readwrite) NSString *photoOrign;
@property (nullable, copy, nonatomic, readwrite) NSString *photoMiddle;
@property (nullable, copy, nonatomic, readwrite) NSString *mobilePhone;
@property (assign, nonatomic, readwrite) BOOL online;
@property (assign, nonatomic, readwrite) BOOL onlineMobile;

@end
