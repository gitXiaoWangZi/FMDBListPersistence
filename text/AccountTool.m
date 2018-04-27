//
//  AccountTool.m
//  text
//
//  Created by Mr_Du on 2018/4/27.
//  Copyright © 2018年 Mr.Liu. All rights reserved.
//

#import "AccountTool.h"
#import <FMDatabase.h>

@interface AccountTool()

@property (nonatomic,strong) FMDatabase *db;

@end

static AccountTool *tool = nil;
@implementation AccountTool

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[AccountTool alloc] init];
    });
    return tool;
}

//创建表
- (void)creatTable{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.sqlite"];
    self.db = [FMDatabase databaseWithPath:filePath];
    if ([self.db open]) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
    
    BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_account (name text NOT NULL, key text NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}

- (void)removeTable{
    BOOL result = [_db executeUpdate:@"drop table if exists t_account"];
    if (result) {
        NSLog(@"删除表成功");
    } else {
        NSLog(@"删除表失败");
    }
}

- (void)insertMsg:(AccountModel *)model{
    //插入数据
    NSString *key = model.key;
    NSString *name = model.name;
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result = [_db executeUpdate:@"INSERT INTO t_account (key, name) VALUES (?,?)",key,name];
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}

- (NSArray *)showOldMsg{
    NSMutableArray *dataArr = [NSMutableArray array];
    //查询数据
    FMResultSet *result = [_db executeQuery:@"select * from t_account"];
    while ([result next]) {
        NSString *key = [result objectForColumn:@"key"];
        NSString *name = [result objectForColumn:@"name"];
        AccountModel *model = [AccountModel new];
        model.key = key;
        model.name = name;
        [dataArr addObject:model];
    }
    return dataArr;
}
@end
