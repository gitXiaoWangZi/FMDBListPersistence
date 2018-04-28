//
//  AccountModel.h
//  text
//
//  Created by Mr_Du on 2018/4/27.
//  Copyright © 2018年 Mr.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *collect_num;
@property (nonatomic,copy) NSString *food_str;
@property (nonatomic,copy) NSString *num;

@end
