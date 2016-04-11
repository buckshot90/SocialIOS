//
//  POOVkFriendTableViewCell.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 05.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "POOVkFriendTableViewCell.h"

@interface POOVkFriendTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIImageView *online;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lableWidht;

@end

@implementation POOVkFriendTableViewCell

+ (instancetype) cell {
    return  [[[[self class] cellNib]instantiateWithOwner:nil options:nil] firstObject];
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:[[self class] identifier] bundle:nil];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

- (void)configWithName:(NSString *)name secondName:(NSString *)secondName online:(BOOL)online image:(NSString *)image {
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userImage.image = [self combainBottomImage:image withSecondImage:[UIImage imageNamed:@"Profile_Avatar"]];
        self.userImage.layer.cornerRadius = 10.0f;
        self.userImage.layer.masksToBounds = YES;
    }];
    
    [self setName:name secondName:secondName];
    [self setOnlineImage:online];
}

- (UIImage *)combainBottomImage:(UIImage *)bottomImage withSecondImage:(UIImage *)secondImage {
    CGSize newSize = CGSizeMake(self.userImage.frame.size.width, self.userImage.frame.size.height);
    UIGraphicsBeginImageContext(newSize);
    
    [bottomImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    [secondImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)blendMode:kCGBlendModeNormal alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)setName:(NSString *)name secondName:(NSString *)secondName {
    NSString *nameAndSecondName = [NSString stringWithFormat:@"%@ %@",name, secondName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:nameAndSecondName];
    
    NSRange range = [nameAndSecondName rangeOfString:secondName];
    
    UIFont *fontBold = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    [attributedString addAttribute:NSFontAttributeName value:fontBold range:range];
    self.userName.attributedText = attributedString;
}

- (void)updateConstraints {
    [super updateConstraints];
    self.lableWidht.constant = [self.userName.text
                          boundingRectWithSize:self.userName.frame.size
                          options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{ NSFontAttributeName:self.userName.font }
                          context:nil]
    .size.width + 5;
}

- (void)setOnlineImage:(BOOL)online {
    if (online) {
        self.online.image = [UIImage imageNamed:@"Online"];
    } else {
        self.online.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
