//
//  SOLBaseDataDisplayManager.h
//  Social
//
//  Created by Vitaliy Rusinov on 4/10/16.
//

#import <Foundation/Foundation.h>
#import "SOLDataDisplayManager.h"
#import "SOLCellObjectBuilder.h"

@interface SOLBaseDataDisplayManager : NSObject <SOLDataDisplayManager, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) id<SOLCellObjectBuilder> cellObjectBuilder;
@property (weak, nonatomic) id<SOLDataDisplayManagerDelegate> delegate;
@property (weak, nonatomic) id<SOLDataDisplayManagerDataSource> dataSource;

@property (strong, nonatomic) NSArray *cellObjsSearch;
@property (strong, nonatomic) NSArray *cellObjs;
@property (strong, nonatomic) NSArray *plainObjs;
@property (assign, nonatomic) BOOL registeredNib;

@end
