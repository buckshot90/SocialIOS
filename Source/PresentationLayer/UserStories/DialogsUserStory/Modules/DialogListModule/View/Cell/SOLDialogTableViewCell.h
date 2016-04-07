//
//  SOLDialogTableViewCell.h
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SOLDialogTableViewCellObject;

@interface SOLDialogTableViewCell : UITableViewCell

- (BOOL)shouldUpdateCellWithObject:(SOLDialogTableViewCellObject *)object;
+ (CGFloat)heightForObject:(SOLDialogTableViewCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end
