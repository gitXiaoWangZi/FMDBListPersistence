//
//  ViewController.m
//  text
//
//  Created by Mr_Du on 2018/4/27.
//  Copyright © 2018年 Mr.Liu. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>
#import "AccountModel.h"
#import "AccountTool.h"
#import <MJExtension.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *keyTF;
@property (weak, nonatomic) IBOutlet UITableView *myTableV;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) AccountTool *tool;
@end

static NSString *const cellID = @"cellID";
@implementation ViewController

- (IBAction)searchClick:(id)sender {
    
    [self.tool removeTable];
    [self.tool creatTable];
    [self.dataArray removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:@"http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?scope=103&format=json&appid=379020&bk_key=%@&bk_length=600",self.keyTF.text];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"网络响应：response：%@-----------%@",response,data);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"网络响应：dict：%@",dict);
        NSArray *dataArr = dict[@"card"];
        for (NSDictionary *dic in dataArr) {
            AccountModel *model = [AccountModel mj_objectWithKeyValues:dic];
            [self.tool insertMsg:model];
            [self.dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableV reloadData];
        });
    }];
    
    [dataTask resume];
}
//房间
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableV.delegate = self;
    self.myTableV.dataSource = self;
    [self.myTableV registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.tool creatTable];
    self.dataArray = [[self.tool showOldMsg] mutableCopy];
    if (self.dataArray.count > 0) {
        [self.myTableV reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountModel *model = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = model.key;
    cell.detailTextLabel.text = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (AccountTool *)tool{
    if (!_tool) {
        _tool = [AccountTool shareInstance];
    }
    return _tool;
}
@end
