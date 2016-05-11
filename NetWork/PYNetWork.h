//
//  PYHttpRequest.h
//  UtileScourceCode
//
//  Created by wlpiaoyi on 15/11/26.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


typedef NSUInteger PYRequestType;
NS_ENUM(PYRequestType) {
    PYRequestGet = 0,
    PYRequestPost = 1,
    PYRequestPut = 2,
    PYRequestDelete = 3,
};


@protocol  PYHttpRequest;
//http请求反馈
typedef void (^BlockHttpRequest)(NSInteger status, id _Nullable data, id<PYHttpRequest> _Nonnull target);

@protocol PYHttpRequest <NSObject>
@required
@property (nonatomic, strong, nullable) id userInfo;
@property (nonatomic, strong, nonnull) NSString * url;
@property (nonatomic) NSStringEncoding encoding;
@property (nonatomic) CGFloat outTime;
/**
 添加头信息
 */
-(void) setHeadRequest:(NSDictionary<NSString * , NSString * > * _Nonnull) headRequest;
/**
 开始请求数据
 @type : 请求类型
 @params : 参数
 @blockComplete : 回调
 */
-(nullable NSURLConnection *) requestWithType:(PYRequestType) type params:(nullable NSDictionary<NSString *, NSObject *> *) params blockComplete:(nullable BlockHttpRequest) blockComplete;
/**
 取消请求
 */
-(BOOL) cancel;
@end

@protocol PYHttpTask;

static NSString * _Nonnull  STATIC_DOWNLOAD_CACHE;
static NSTimeInterval   STATIC_OUT_TIME;
//http请求反馈
typedef void (^BlockHttpTask)(id _Nullable data, id<PYHttpTask> _Nonnull target);
@protocol PYHttpTask <NSObject>
@required
@property (nonatomic) NSTimeInterval outTime;
@property (nonatomic, strong, nullable) NSString * identifier;
@property (nonatomic, strong, nullable) id userInfo;
//下载地址
@property (nonatomic, strong, nullable) NSString * stringUrl;
@property (nonatomic, strong, nullable) NSData * dataResume;
@property (nonatomic, readonly, nonnull) NSURLSessionTask * task;
/**
 请求反馈
 */
//==>
-(instancetype _Nonnull) setBlockSuccess:(BlockHttpTask _Nullable) blockSuccess;
-(instancetype _Nonnull) setBlockFaild:(BlockHttpTask _Nullable) blockFaild;
-(instancetype _Nonnull) setBlockProgress:(void (^_Nullable) (id<PYHttpTask> _Nonnull target,int64_t currentBytes, int64_t totalBytes)) blockProgress;
//下载请求恢复数取消
-(instancetype _Nonnull) setBlockCancel:(BlockHttpTask _Nullable) blockCancel;
//<==
-(BOOL) resume;
-(BOOL) suspend;
-(BOOL) cancel;
@end


