//
//  SOLCellObjectBuilder.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOLPlainObject.h"

@protocol SOLCellObjectBuilder <NSObject>

- (NSArray *)cellObjectsForPlainObjects:(NSArray *)plainObjects;

@end
