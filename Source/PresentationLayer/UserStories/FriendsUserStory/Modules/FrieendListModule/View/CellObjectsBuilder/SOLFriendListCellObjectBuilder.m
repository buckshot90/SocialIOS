//
//  SOLFriendListCellObjectBuilder.m
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import "SOLFriendListCellObjectBuilder.h"
#import "SOLCellObjectBuilder.h"
#import "SOLUserPlainObject.h"
#import "SOLFriendListTableViewCellObject.h"

@implementation SOLFriendListCellObjectBuilder

- (NSArray *)cellObjectsForPlainObjects:(NSArray *)plainObjects {
    
    NSMutableArray *manageObjs = [[NSMutableArray alloc] init];
    for (SOLUserPlainObject *plain in plainObjects) {
        
        SOLFriendListTableViewCellObject *cellObj = [SOLFriendListTableViewCellObject objectWithUser:plain];
        [manageObjs addObject:cellObj];
    }
    
    return manageObjs;
}

@end
