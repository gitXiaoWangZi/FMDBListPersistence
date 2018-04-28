//
//  MenuCell.m
//  text
//
//  Created by Mr_Du on 2018/4/28.
//  Copyright © 2018年 Mr.Liu. All rights reserved.
//

#import "MenuCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MenuCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *desL;
@property (weak, nonatomic) IBOutlet UILabel *numL;

@end

@implementation MenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AccountModel *)model{
    _model = model;
//    self.icon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.pic]]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.titleL.text = model.title;
    self.desL.text = model.food_str;
    self.numL.text = [NSString stringWithFormat:@"共有%@人做过",model.collect_num];
}

@end
