//
//  PYHttpRequest.m
//  UtileScourceCode
//
//  Created by wlpiaoyi on 15/11/26.
//  Copyright © 2015年 wlpiaoyi. All rights reserved.
//

#import "PYHttpRequest.h"
#import <Utile/Utile.Framework.h>


const NSString * HTTP_HEAD_KEY_ContentType = @"Content-Type";
const NSString * HTTP_HEAD_VALUE_ContentType_JSON = @"application/json";
const NSString * HTTP_HEAD_VALUE_ContentType_Normal = @"application/x-www-form-urlencoded";
const NSString * HTTP_HEAD_VALUE_ContentType_Encode = @"charset=";


//==>传输方法
const NSString * HTTP_GET = @"GET";
const NSString * HTTP_POST = @"POST";
const NSString * HTTP_PUT = @"PUT";
const NSString * HTTP_DELETE = @"DELETE";
//<==


CGFloat PYHttpRequestOutTime = 30.0;
@interface PYHttpRequest()<NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSDictionary <NSString * , NSString * > * _Nullable _headRequest_;
@property (nonatomic, copy) BlockHttpRequest blockComplete;
@property (nonatomic,strong) NSURLConnection	*connection;
@property (nonatomic,strong) NSMutableData *data;
@property (nonatomic) NSInteger statusCode;

@end

@implementation PYHttpRequest
-(instancetype) init{
    if (self = [super init]) {
        self.outTime = PYHttpRequestOutTime;
        self.encoding = NSUTF8StringEncoding;
        self._headRequest_ = @{HTTP_HEAD_KEY_ContentType:[NSString stringWithFormat:@"%@;%@UTF-8",HTTP_HEAD_VALUE_ContentType_Normal,HTTP_HEAD_VALUE_ContentType_Encode]};
    }
    return self;
}
/**
 添加头信息
 */
-(void) setHeadRequest:(NSDictionary<NSString * , NSString * > * _Nonnull) headRequest{
    self._headRequest_ = headRequest;
}

/**
 开始请求数据
 */
-(nullable NSURLConnection *) requestWithType:(PYRequestType) type params:(nullable NSDictionary<NSString *, NSObject *> *) params blockComplete:(nullable BlockHttpRequest) blockComplete;{
    
    if (self.url == nil) {
        return nil;
    }
    
    [self cancel];
    
    self.blockComplete = blockComplete;
    
    NSURLConnection * connection = nil;
    
    switch (type) {
        case PYRequestGet:{
            connection = [self requestGet:self.url params:params];
        }
            break;
        case PYRequestPost:{
            connection = [self requestPost:self.url params:params];
        }
            break;
        case PYRequestPut:{
            connection = [self requestPut:self.url params:params];
        }
            break;
        case PYRequestDelete:{
            connection = [self requestDelete:self.url params:params];
        }
            break;
        default:
            break;
    }
    
    return connection;
}

/**
 开始请求数据
 */
//==>
-(NSURLConnection * _Nullable) requestGet:(NSString * _Nonnull) urlString params:(NSDictionary<NSString *, NSObject *> * _Nullable) params{
    NSMutableURLRequest *request = [self createUrlRequest:params outTime:self.outTime urlString:urlString];
    [request setHTTPMethod:(NSString*)HTTP_GET];
    self.connection = [self startAsynRequest:request];
    return self.connection;
}
-(NSURLConnection * _Nullable) requestPost:(NSString * _Nonnull) urlString params:(NSDictionary<NSString *, NSObject *> * _Nullable) params{
    NSMutableURLRequest *request = [self createDataRequest:params outTime:self.outTime urlString:urlString];
    [request setHTTPMethod:(NSString*)HTTP_POST];
    self.connection = [self startAsynRequest:request];
    return self.connection;
}
-(NSURLConnection * _Nullable) requestPut:(NSString * _Nonnull) urlString params:(NSDictionary<NSString *, NSObject *> * _Nullable) params{
    NSMutableURLRequest *request = [self createDataRequest:params outTime:self.outTime urlString:urlString];
    [request setHTTPMethod:(NSString*)HTTP_PUT];
    self.connection = [self startAsynRequest:request];
    return self.connection;
}
-(NSURLConnection * _Nullable) requestDelete:(NSString * _Nonnull) urlString params:(NSDictionary<NSString *, NSObject *> * _Nullable) params{
    NSMutableURLRequest *request = [self createUrlRequest:params outTime:self.outTime urlString:urlString];
    [request setHTTPMethod:(NSString*)HTTP_DELETE];
    self.connection = [self startAsynRequest:request];
    return self.connection;
}
//<==

/**
 取消请求
 */
-(BOOL) cancel{
    if (!self.connection) {
        return false;
    }
    [self.connection cancel];
    self.connection = nil;
    self.blockComplete = nil;
    self.userInfo = nil;
    self.data = nil;
    return true;
}


-(NSURLConnection*) startAsynRequest:(NSURLRequest*) request{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.data = [NSMutableData new];
    [connection start];
#ifdef DEBUG
    printf("Http:%s\n",[[[request URL] absoluteString] UTF8String]);
#endif
    return connection;
}

-(NSMutableURLRequest*) createUrlRequest:(NSDictionary<NSString *, NSObject *> *) params outTime:(NSTimeInterval) outTime urlString:(NSString*) urlString{
    NSMutableString *finallyUrlStr = [[NSMutableString alloc] initWithString:urlString];
    if (params) {
        [finallyUrlStr appendString:[urlString rangeOfString:@"?"].length == 1 ? @"&" : @"?"];
        [finallyUrlStr appendString:[PYHttpRequest checkParamsConstructionToNormarl:params encoding:self.encoding]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: finallyUrlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:outTime];
    
    if (self._headRequest_) {
        [PYHttpRequest addAllHttpHeaderFields:self._headRequest_ request:request];
    }
    return request;
}

-(NSMutableURLRequest*) createDataRequest:(NSDictionary<NSString *, NSObject *> *) params outTime:(NSTimeInterval) outTime urlString:(NSString*) urlString{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:outTime];
    if (self._headRequest_) {
        [PYHttpRequest addAllHttpHeaderFields:self._headRequest_ request:request];
    }
    if (params) {
        NSData *postData = [self checkParamsConstruction:params];
        [request setHTTPBody:postData];
        NSString *postLength = [NSString stringWithFormat:@"%li", (unsigned long)[postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    }
    return request;
}

-(NSData*) checkParamsConstruction:(NSDictionary*) dicParam{
    if (!dicParam) {
        return nil;
    }
    NSString *contentType = [self._headRequest_ objectForKey:(NSString*)HTTP_HEAD_KEY_ContentType];
    if ([contentType rangeOfString:((NSString*)HTTP_HEAD_VALUE_ContentType_JSON)].length) {
        return [dicParam toData];
    }else{
        return [[PYHttpRequest checkParamsConstructionToNormarl:dicParam encoding:self.encoding] dataUsingEncoding:self.encoding];
    }
}


+(NSString*) checkParamsConstructionToNormarl:(NSDictionary*) dicParam encoding:(NSStringEncoding) encoding{
    NSMutableString *stringParams = [NSMutableString new];
    
    for (NSString *key in [dicParam allKeys]) {
        id value = [dicParam objectForKey:key];
        if (value) {
            if ([value isKindOfClass:[NSString class]]) {
                [stringParams appendFormat:@"&%@=%@",key,value];
            }else if([value isKindOfClass:[NSNumber class]]){
                [stringParams appendFormat:@"&%@=%@",key,[((NSNumber*)value) stringValueWithPrecision:8]];
            }else if([value isKindOfClass:[NSData class]]){
                [stringParams appendFormat:@"&%@=%@",key,[[NSString alloc] initWithData:value encoding:encoding]];
            }else if([value isKindOfClass:[NSArray class]]||[value isKindOfClass:[NSDictionary class]]){
                [stringParams appendFormat:@"&%@=%@",key,[[NSString alloc] initWithData:[value toData] encoding:NSUTF8StringEncoding]];
            }
        }
    }
    if (stringParams.length > 1) {
        return [stringParams substringFromIndex:1];
    }
    return stringParams;
}

+(void) addAllHttpHeaderFields:(NSDictionary<NSString *, NSString *>*) headerFilelds request:(NSMutableURLRequest*) request{
    for (NSString *key in [headerFilelds allKeys]) {
        [request setValue:[headerFilelds objectForKey:key] forHTTPHeaderField:key];
    }
}

#pragma NSURLConnectionDelegate ==>
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    if (self.blockComplete) {
        _blockComplete(self.statusCode, error, self);
    }
    [self cancel];
}
#pragma NSURLConnectionDelegate<==

#pragma NSURLConnectionDataDelegate ==>
- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response{
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.statusCode = ((NSHTTPURLResponse*)response).statusCode;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    @synchronized(self.data) {
        [self.data appendData:data];
    }
}

- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;{
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (self.blockComplete) {
        self.blockComplete(self.statusCode,self.data,self);
    }
    [self cancel];
}
#pragma NSURLConnectionDataDelegate <==

@end
