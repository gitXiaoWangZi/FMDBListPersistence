//
//  AccountTool.h
//  text
//
//  Created by Mr_Du on 2018/4/27.
//  Copyright © 2018年 Mr.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

@interface AccountTool : NSObject

+ (instancetype)shareInstance;
- (void)creatTable;
- (void)removeTable;
- (void)insertMsg:(AccountModel *)model;
- (NSArray *)showOldMsg;
@end
