//
//  PYHttpDownloadTask.h
//  UtileScourceCode
//
//  Created by wlpiaoyi on 15/11/27.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "PYNetWork.h"
@interface PYHttpDownloadTask : NSObject<PYHttpTask>
@property (nonatomic) NSTimeInterval outTime;
@property (nonatomic, strong, nullable) NSString * identifier;
@property (nonatomic, strong, nullable) id userInfo;
//下载地址
@property (nonatomic, strong, nullable) NSString * stringUrl;
@property (nonatomic, strong, nullable) NSData * dataResume;
@property (nonatomic, readonly, nonnull) NSURLSessionTask * task;

@end
