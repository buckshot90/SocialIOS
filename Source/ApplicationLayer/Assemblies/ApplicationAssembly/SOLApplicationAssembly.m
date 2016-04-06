//
//  SOLApplicationAssembly.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLApplicationAssembly.h"
#import "AppDelegate.h"
#import "SOLThirdPartiesConfigurator.h"
#import "SOLThirdPartiesConfiguratorImplementation.h"

@implementation SOLApplicationAssembly

- (void)configure {
    
    [self p_appDelegate];
}

- (AppDelegate *)p_appDelegate {

    AppDelegate *appDelegateAssebly = [[UIApplication sharedApplication] delegate];
    appDelegateAssebly.thirdPartiesConfigurator = [self p_thirdPartiesConfigurator];
    return appDelegateAssebly;
}

- (id <SOLThirdPartiesConfigurator>)p_thirdPartiesConfigurator {
    
    id <SOLThirdPartiesConfigurator> third = [[SOLThirdPartiesConfiguratorImplementation alloc] init];
    return third;
}

@end
