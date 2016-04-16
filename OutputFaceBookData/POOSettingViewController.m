//
//  POOSettingViewController.m
//  OutputFaceBookData
//
//  Created by Oleh Petrunko on 15.04.16.
//  Copyright © 2016 Oleh Petrunko. All rights reserved.
//

#import "POOSettingViewController.h"
#import "Consts.h"

@interface POOSettingViewController ()

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSUserDefaults *userDefult;

@end

@implementation POOSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefult = [NSUserDefaults standardUserDefaults];
    
    [self setNameLable];
    [self configImageView];
}

- (void)setNameLable {
    self.name.text = [NSString stringWithFormat:@"%@ %@",
                      [self.userDefult objectForKey:kConstsNameKey],
                      [self.userDefult objectForKey:kConstsNameKey]];
}

- (void) configImageView {
    self.imageView.image = [UIImage imageWithData:
                            [NSData dataWithContentsOfURL:
                             [NSURL URLWithString:
                              [self.userDefult objectForKey:kConstsUserPhotoKey]]]];
    
    self.imageView.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
