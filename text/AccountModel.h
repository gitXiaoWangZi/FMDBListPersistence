//
//  AccountModel.h
//  text
//
//  Created by Mr_Du on 2018/4/27.
//  Copyright © 2018年 Mr.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *key;

@end
