//
//  ViperModuleFactoryProtocol.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/12/16.
//  Copyright © 2016 OCP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViperTransitionModeratorProtocol;

@protocol ViperModuleFactoryProtocol <NSObject>

- (nullable id<ViperTransitionModeratorProtocol>)instantiateModuleTransitionModerator;

@end
