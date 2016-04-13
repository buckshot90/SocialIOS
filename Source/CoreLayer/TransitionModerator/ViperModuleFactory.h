//
//  ViperModuleFactory.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//  Copyright © 2016 OCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ViperModuleFactoryProtocol.h"

@interface ViperModuleFactory : NSObject <ViperModuleFactoryProtocol>

- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard andRestorationId:(NSString *)restorationId;
@property (strong, nonatomic, readonly) UIStoryboard *storyboard;
@property (strong, nonatomic, readonly) NSString *restorationId;

@end
