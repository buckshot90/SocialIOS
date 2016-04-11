//
//  POOVKTableViewCell.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 16.02.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "POOVKTableViewCell.h"
#import "String+Md5.h"
#import "POOCache.h"

@interface POOVKTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *fullnameOrStatus;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@end

@implementation POOVKTableViewCell

+ (instancetype) cell {
    return [[[[self class] cellNib]instantiateWithOwner:nil options:nil] firstObject];
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:[[self class] identifier] bundle:nil];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

- (void)configureWithName:(NSString *)name  SecondName:(NSString *) secondName {
    self.name.text = name;
    if (secondName.length > 0) {
        self.fullnameOrStatus.text = [NSString stringWithFormat:@"%@ %@", name, secondName];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)configureWithTitleLabel:(NSString *)titleString  andSubtitleLabel:(NSString *) SubTitleLabel {
    self.name.text = titleString;
    self.fullnameOrStatus.text = SubTitleLabel;
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:SubTitleLabel]];
}


- (void)updateConstraints {
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
