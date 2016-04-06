//
//  SOLThirdPartiesConfigurator.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol SOLThirdPartiesConfigurator <NSObject>

- (void)configure;
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
- (void)applicationDidBecomeActive:(UIApplication *)application;

@end
