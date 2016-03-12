//
//  PYHttpRequest.h
//  UtileScourceCode
//
//  Created by wlpiaoyi on 15/11/26.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "PYNetWork.h"

extern CGFloat PYHttpRequestOutTime;

@interface PYHttpRequest : NSObject<PYHttpRequest>
@property (nonatomic, strong, nonnull) NSString * url;
@property (nonatomic, strong) id _Nullable userInfo;
@property (nonatomic) NSStringEncoding encoding;
@property (nonatomic) CGFloat outTime;
@end
