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
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) download{
    PYHttpDownloadTask *download = [PYHttpDownloadTask new];
    download.stringUrl = @"http://192.168.1.77:8080/test/ad.wlpiaoyi?a=1";
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
