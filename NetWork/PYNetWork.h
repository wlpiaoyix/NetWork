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

//http请求反馈
typedef void (^BlockHttpTask)(id _Nullable data, id<PYHttpTask> _Nonnull target);
@protocol PYHttpTask <NSObject>
@required
@property (nonatomic, strong) NSString * _Nullable identifier;
@property (nonatomic, strong) id _Nullable userInfo;
//下载地址
@property (nonatomic, strong) NSString * _Nullable stringUrl;
@property (nonatomic, strong) NSData * _Nullable dataResume;
@property (nonatomic, readonly) NSURLSessionTask * _Nonnull task;
/**
 请求反馈
 */
//==>
-(instancetype _Nonnull) setBlockSuccess:(BlockHttpTask _Nullable) blockSuccess;
-(instancetype _Nonnull) setBlockFaild:(BlockHttpTask _Nullable) blockFaild;
-(instancetype _Nonnull) setBlockProgress:(void (^_Nullable) (int64_t currentBytes, int64_t totalBytes)) blockProgress;
//下载请求恢复数取消
-(instancetype _Nonnull) setBlockCancel:(BlockHttpTask _Nullable) blockCancel;
//<==
-(BOOL) resume;
-(BOOL) suspend;
-(BOOL) cancel;
@end


