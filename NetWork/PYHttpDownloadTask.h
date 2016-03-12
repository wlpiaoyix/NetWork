//
//  PYHttpDownloadTask.h
//  UtileScourceCode
//
//  Created by wlpiaoyi on 15/11/27.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "PYNetWork.h"
@interface PYHttpDownloadTask : NSObject<PYHttpTask>
@property (nonatomic, strong) NSString * _Nullable identifier;
@property (nonatomic, strong) id _Nullable userInfo;
//下载地址
@property (nonatomic, strong) NSString * _Nullable stringUrl;
@property (nonatomic, strong) NSData * _Nullable dataResume;
@property (nonatomic, readonly) NSURLSessionTask * _Nonnull task;

@end
