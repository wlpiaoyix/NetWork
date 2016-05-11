//
//  ViewController.m
//  NetWork
//
//  Created by wlpiaoyi on 15/12/23.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "ViewController.h"
#import "PYHttpDownloadTask.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self download];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) download{
    PYHttpDownloadTask *download = [PYHttpDownloadTask new];
    download.stringUrl = @"http://127.0.0.1:8080/WlServlet/ad.wlpiaoyi?a=1";
    download.identifier = @"adfadsfadsfaddkk";
    [download setBlockProgress:^(id<PYHttpTask> target, int64_t currentBytes, int64_t totalBytes) {
        NSLog(@"%f",(CGFloat)currentBytes / (CGFloat)totalBytes);
    }];
    [download setBlockCancel:^(id  _Nullable data, id<PYHttpTask>  _Nonnull target) {
        NSLog(@"");
    }];
    [download setBlockFaild:^(id  _Nullable data, id<PYHttpTask>  _Nonnull target) {
        NSLog(@"");
    }];
    [download setBlockSuccess:^(id  _Nullable data, id<PYHttpTask>  _Nonnull target) {
        NSLog(@"");
    }];
    [download resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
