//
//  ViperModuleFactory.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//  Copyright © 2016 OCP. All rights reserved.
//

#import "ViperModuleFactory.h"

@interface ViperModuleFactory ()

@property (strong, nonatomic) UIStoryboard *storyboard;
@property (strong, nonatomic) NSString *restorationId;

@end

@implementation ViperModuleFactory

- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard andRestorationId:(NSString *)restorationId {
    
    self = [super init];
    if (self) {
        self.storyboard = storyboard;
        self.restorationId = restorationId;
    }
    return self;
}

#pragma mark - RDSModuleFactoryProtocol

- (id<ViperTransitionModeratorProtocol>)instantiateModuleTransitionModerator {
    
    id<ViperTransitionModeratorProtocol>destinationViewController = [_storyboard instantiateViewControllerWithIdentifier:_restorationId];
    return destinationViewController;
}

@end
