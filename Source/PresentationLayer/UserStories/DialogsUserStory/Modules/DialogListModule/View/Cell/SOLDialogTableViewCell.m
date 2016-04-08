//
//  SOLDialogTableViewCell.m
//  OutputFaceBookData
//
//  Created by Vitaliy Rusinov on 4/7/16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "SOLDialogTableViewCell.h"
#import "SOLDialogTableViewCellObject.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

static CGFloat const kReportListTableViewCellHeight = 60.0f;

@interface SOLDialogTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *dialogThumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *dialogTitle;
@property (weak, nonatomic) IBOutlet UILabel *dialogBody;
@property (weak, nonatomic) IBOutlet UILabel *dialogDate;

@end

@implementation SOLDialogTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _dialogThumbnailImageView.clipsToBounds = YES;
    _dialogThumbnailImageView.layer.cornerRadius = 6.0;
}

- (BOOL)shouldUpdateCellWithObject:(SOLDialogTableViewCellObject *)object {
    
    self.dialogTitle.text = object.dialogTitle;
    self.dialogBody.text = object.dialogBody;
    self.dialogDate.text = object.dialogDate;
    [self.dialogThumbnailImageView setImageWithURL:object.dialogThumbnailUrl placeholderImage:nil];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    return kReportListTableViewCellHeight;
}

@end