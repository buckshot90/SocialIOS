//
//  SOLDialogCellObjectBuilder.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogCellObjectBuilder.h"
#import "SOLCellObjectBuilder.h"
#import "SOLMessagePlainObject.h"
#import "SOLDialogTableViewCellObject.h"

@implementation SOLDialogCellObjectBuilder

- (NSArray *)cellObjectsForPlainObjects:(NSArray *)plainObjects {
    
    NSMutableArray *cellObjects = [NSMutableArray array];
    for (SOLMessagePlainObject *plain in plainObjects) {
        
        SOLDialogTableViewCellObject *cellObj = [SOLDialogTableViewCellObject objectWithMessage:plain];
        [cellObjects addObject:cellObj];
    }
    
    return cellObjects;
}

@end
