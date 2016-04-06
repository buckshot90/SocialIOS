//
//  SOLInitializer.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/6/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLInitializer.h"
#import "SOLApplicationAssembly.h"

@interface SOLInitializer ()
@property (weak, nonatomic) IBOutlet UITabBarController *rootViewController;
@end

@implementation SOLInitializer

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self p_initialize];
}

- (void)p_initialize {
    
    SOLApplicationAssembly *appAssembly = [[SOLApplicationAssembly alloc] init];
    [appAssembly configure];
}

@end
