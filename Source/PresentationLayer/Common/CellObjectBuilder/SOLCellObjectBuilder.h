//
//  SOLCellObjectBuilder.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//

#import <Foundation/Foundation.h>

@protocol SOLCellObjectBuilder <NSObject>

- (NSArray *)cellObjectsForPlainObjects:(NSArray *)plainObjects;

@end
