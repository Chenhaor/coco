//
//  GWHttpRequestParam.m
//  SmallGowildClient
//
//  Created by yangye on 16/5/26.
//  Copyright © 2016年 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWHttpRequestParamModel.h"
#import <objc/runtime.h>
#import <GWLogListTest/GWLogListTest.h>
#import "AFURLResponseSerialization.h"

@implementation GWHttpRequestParamModel

@synthesize flag = _flag;
@synthesize callback = _callback;
@synthesize timeOut = _timeOut;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.reqType = HTTP_REQUESTPYE_POST;
        self.parmaFormat = HTTP_PARMA_FORMAT_KEYVALUE;
    }
    
    return self;
}

#pragma mark setter/getter
- (NSDictionary *)keysTransfer
{
    return nil;
}

- (NSSet *)ignoreList
{
    return [[NSSet alloc] initWithObjects:@"reqType", @"interfaceUrl",@"callback",@"parmaFormat",@"authorization", nil];
}

#pragma mark - @protocol
- (NSDictionary *)reqParamDic
{
    NSMutableArray* propertyArray = [[NSMutableArray alloc] init];
    NSMutableArray* valueArray = [[NSMutableArray alloc] init];
    
    Class subclass = [self class];
    
    while (subclass != [GWHttpRequestParamModel class])
    {
        u_int count = 0;
        
        objc_property_t* properties = class_copyPropertyList(subclass, &count);
        
        for (int i = 0; i < count ; i++)
        {
            objc_property_t prop=properties[i];
            const char* propertyName = property_getName(prop);
            NSString *property = [NSString  stringWithCString:propertyName
                                                     encoding:NSUTF8StringEncoding];
            
            id value = [self valueForKey: [NSString stringWithUTF8String:propertyName]];
            
            if (value != nil)
            {
                //如果存在并且不被忽略
                if (property && ![self.ignoreList containsObject:property])
                {
                    //replace transfer key
                    if ([self.keysTransfer objectForKey:property])
                    {
                        property = [self.keysTransfer objectForKey:property];
                    }
                    
                    [propertyArray addObject:property];
                    [valueArray addObject:value];
                }
            }
        }
        free(properties);
        
        // 不去遍历父类
        subclass = class_getSuperclass(subclass);
    }
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    return returnDic;
}

- (void)requestFinishedCallback:(id)result
{
    //defualt data type is JSON
    if (result && [result isKindOfClass:[NSData class]])
    {
        NSError *jsonErr = nil;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:result
                                                     options:0
                                                       error:&jsonErr];
        if (!jsonErr && jsonObj)
        {
            GWLog(@"服务器返回数据%@", jsonObj);
            GWHttpResponseBase *response = [self getResponseWithInfo:jsonObj
                                                                 err:jsonErr];
            //处理账号相关的错误
            /*
             CODE_2200(2200, "系统内部错误"),
             CODE_2201(2201, "系统内部错误"),
             CODE_2202(2202, "免登录信息已过期，请重新登录"),
             CODE_2203(2203, "登录过期，请重新登录"),
             CODE_2204(2204, "登录过期，请重新登录"),
             CODE_2205(2205, "用户名或密码错误"),
             CODE_2206(2206, "登录过期，请重新登录"),
             CODE_2207(2207, "登录过期，请重新登录"),
             CODE_2208(2208, "登录过期，请重新登录"),
             CODE_2209(2209, "登录过期，请重新登录"),
             CODE_2210(2210, "登录过期，请重新登录"),
             CODE_2211(2211, "登录过期，请重新登录"),
             CODE_2212(2212, "登录过期，请重新登录"),
             CODE_2213(2213, "登录过期，请重新登录"),
             CODE_2214(2214, "登录过期，请重新登录"),
             */
            switch (response.code)
            {
                case 2202:
                case 2203:
                {
                    NSString *errMsg = @"登录信息过期，请重新登录";
                    GWLog(@"errMsg = %@",errMsg);
                    self.callback = nil;
                }
                    break;

                case 2204:
                case 2206:
                case 2207:
                case 2208:
                case 2209:
                case 2210:
                case 2211:
                case 2212:
                case 2213:
                case 2214:
                    GWLog(@"刷新token");

                    break;
                default:
                    break;
            }
            if (self.callback)
            {
                self.callback(response, response.error);
            }
        }
        else
        {
            jsonErr = [NSError errorWithDomain:@"服务请求异常，返回数据错误"
                                          code:3840
                                      userInfo:nil];
            if (self.callback)
            {
                self.callback(nil, jsonErr);
            }
        }
    }
    else
    {
        GWLog(@"服务器返回不支持类型数据%@", result);
        NSError *error = [NSError errorWithDomain:@"未知数据类型"
                                             code:-1
                                         userInfo:nil];
        if (self.callback)
        {
            self.callback(nil, error);
        }
    }
}

- (void)requestErrorCallback:(NSError *)error
{
    if (error)
    {
        NSInteger errCode = error.code;
        //需要处理http的错误码，授权部分的错误是根据该错误码处理的
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)[error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
//        if (response)
//        {
//            errCode = response.statusCode;
//            
//            switch (errCode)
//            {
//                case 400: ////RefreshToken无效 [重新登录]
//                {
//                    self.callback = nil;
//                    NSString *errMsg = @"登录信息过期，请重新登录";
//                    [mAppDelegate showTokenExpire:errMsg];
//                }
//                    break;
//                case 401: //Token无效 [需要重新刷新Token]
//                {
//                    [GWAccountModule refreshToken];
//                }
//                    break;
//                    
//                default:
//                    break;
//            }
//        }
        //转换本地显示
        error = [NSError errorWithDomain:[self getNetworkErrorMsgLocalWithErrorCode:errCode]
                                    code:errCode
                                userInfo:nil];
    }
    
    if (self.callback)
    {
        self.callback(nil, error);
    }
}

- (id<GWResponseDelegate>)getResponseWithInfo:(id)result
                                          err:(NSError *)err
{
    GWHttpResponseBase *response = [[GWHttpResponseBase alloc] initWithData:result
                                                                        err:err];
    return response;
}

#pragma mark private methods
- (NSString *)getNetworkErrorMsgLocalWithErrorCode:(NSInteger)errorCode
{
    NSString *errMsg = @"请求失败,请稍后再试。";
    switch (errorCode)
    {
            //            case -1:
            //                errMsg = @"";
            //                break;
            //            case 1:
            //                errMsg = @"";
            //                break;
            //            case 2:
            //                errMsg = @"";
            //                break;
            //            case 100:
            //                errMsg = @"";
            break;
        case -1001:
            errMsg = @"网络连接超时,请稍后再试。";
            break;
        case -1002:
            errMsg = @"网络连接异常,请稍后再试。";
            break;
        case -1003:
            errMsg = @"网络连接异常,请稍后再试。";
            break;
        case -1009:
            errMsg = @"网络连接已断开";
            break;
        default:
            break;
    }
    
    return errMsg;
}

// system error code description
/*
-1
NSURLErrorUnknown
1
kCFHostErrorHostNotFound	Indicates that the DNS lookup failed.
2
kCFHostErrorUnknown	An unknown error occurred (a name server failure, for example). For additional information, query the kCFGetAddrInfoFailureKey to get the value returned from getaddrinfo; lookup in netdb.h
100
kCFSOCKSErrorUnknownClientVersion	The SOCKS server rejected access because it does not support connections with the requested SOCKS version.Query kCFSOCKSStatusCodeKey to recover the status code returned by the server.
101
kCFSOCKSErrorUnsupportedServerVersion	The version of SOCKS requested by the server is not supported. Query kCFSOCKSStatusCodeKey to recover the status code returned by the server.

Query the kCFSOCKSVersionKey to find the version requested by the server.
SOCKS4 Errors

110
kCFSOCKS4ErrorRequestFailed	Request rejected or failed by the server.
111
kCFSOCKS4ErrorIdentdFailed	Request rejected because SOCKS server cannot connect to identd on the client.
112
kCFSOCKS4ErrorIdConflict	Request rejected because the client program and identd report different user-ids.
113
kCFSOCKS4ErrorUnknownStatusCode	The status code returned by the server is unknown.
SOCKS5 Errors

120
kCFSOCKS5ErrorBadState	The stream is not in a state that allows the requested operation.
121
kCFSOCKS5ErrorBadResponseAddr	The address type returned is not supported.
122
kCFSOCKS5ErrorBadCredentials	The SOCKS server refused the client connection because of bad login credentials.
123
kCFSOCKS5ErrorUnsupportedNegotiationMethod	The requested method is not supported. Query kCFSOCKSNegotiationMethodKey to find the method requested.
124
kCFSOCKS5ErrorNoAcceptableMethod	The client and server could not find a mutually agreeable authentication method.
FTP Errors

200
kCFFTPErrorUnexpectedStatusCode	The server returned an unexpected status code. Query the kCFFTPStatusCodeKey to get the status code returned by the server
HTTP Errors

300
kCFErrorHTTPAuthenticationTypeUnsupported	The client and server could not agree on a supported authentication type.
301
kCFErrorHTTPBadCredentials	The credentials provided for an authenticated connection were rejected by the server.
302
kCFErrorHTTPConnectionLost	The connection to the server was dropped. This usually indicates a highly overloaded server.
303
kCFErrorHTTPParseFailure	The HTTP server response could not be parsed.
304
kCFErrorHTTPRedirectionLoopDetected	Too many HTTP redirects occurred before reaching a page that did not redirect the client to another page. This usually indicates a redirect loop.
305
kCFErrorHTTPBadURL	The requested URL could not be retrieved.
306
kCFErrorHTTPProxyConnectionFailure	A connection could not be established to the HTTP proxy.
307
kCFErrorHTTPBadProxyCredentials	The authentication credentials provided for logging into the proxy were rejected.
308
kCFErrorPACFileError	An error occurred with the proxy autoconfiguration file.
309
kCFErrorPACFileAuth	The authentication credentials provided by the proxy autoconfiguration file were rejected.
310
kCFErrorHTTPSProxyConnectionFailure	A connection could not be established to the HTTPS proxy.
311
kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod	The HTTPS proxy returned an unexpected status code, such as a 3xx redirect.
CFURLConnection & CFURLProtocol Errors

-998
kCFURLErrorUnknown	An unknown error occurred.
-999
kCFURLErrorCancelled
NSURLErrorCancelled	The connection was cancelled.
-1000
kCFURLErrorBadURL
NSURLErrorBadURL	The connection failed due to a malformed URL.
-1001
kCFURLErrorTimedOut
NSURLErrorTimedOut	The connection timed out.
-1002
kCFURLErrorUnsupportedURL
NSURLErrorUnsupportedURL	The connection failed due to an unsupported URL scheme.
-1003
kCFURLErrorCannotFindHost
NSURLErrorCannotFindHost	The connection failed because the host could not be found.
-1004
kCFURLErrorCannotConnectToHost
NSURLErrorCannotConnectToHost	The connection failed because a connection cannot be made to the host.
-1005
kCFURLErrorNetworkConnectionLost
NSURLErrorNetworkConnectionLost	The connection failed because the network connection was lost.
-1006
kCFURLErrorDNSLookupFailed
NSURLErrorDNSLookupFailed	The connection failed because the DNS lookup failed.
-1007
kCFURLErrorHTTPTooManyRedirects
NSURLErrorHTTPTooManyRedirects	The HTTP connection failed due to too many redirects.
-1008
kCFURLErrorResourceUnavailable
NSURLErrorResourceUnavailable	The connection’s resource is unavailable.
-1009
kCFURLErrorNotConnectedToInternet
NSURLErrorNotConnectedToInternet	The connection failed because the device is not connected to the internet.
-1010
kCFURLErrorRedirectToNonExistentLocation
NSURLErrorRedirectToNonExistentLocation	The connection was redirected to a nonexistent location.
-1011
kCFURLErrorBadServerResponse
NSURLErrorBadServerResponse	The connection received an invalid server response.
-1012
kCFURLErrorUserCancelledAuthentication
NSURLErrorUserCancelledAuthentication	The connection failed because the user cancelled required authentication.
-1013
kCFURLErrorUserAuthenticationRequired
NSURLErrorUserAuthenticationRequired	The connection failed because authentication is required.
-1014
kCFURLErrorZeroByteResource
NSURLErrorZeroByteResource	The resource retrieved by the connection is zero bytes.
-1015
kCFURLErrorCannotDecodeRawData
NSURLErrorCannotDecodeRawData	The connection cannot decode data encoded with a known content encoding.
-1016
kCFURLErrorCannotDecodeContentData
NSURLErrorCannotDecodeContentData	The connection cannot decode data encoded with an unknown content encoding.
-1017
kCFURLErrorCannotParseResponse
NSURLErrorCannotParseResponse	The connection cannot parse the server’s response.
-1018
kCFURLErrorInternationalRoamingOff	The connection failed because international roaming is disabled on the device.
-1019
kCFURLErrorCallIsActive	The connection failed because a call is active.
-1020
kCFURLErrorDataNotAllowed	The connection failed because data use is currently not allowed on the device.
-1021
kCFURLErrorRequestBodyStreamExhausted	The connection failed because its request’s body stream was exhausted.
File Errors

-1100
kCFURLErrorFileDoesNotExist
NSURLErrorFileDoesNotExist	The file operation failed because the file does not exist.
-1101
kCFURLErrorFileIsDirectory
NSURLErrorFileIsDirectory	The file operation failed because the file is a directory.
-1102
kCFURLErrorNoPermissionsToReadFile
NSURLErrorNoPermissionsToReadFile	The file operation failed because it does not have permission to read the file.
-1103
kCFURLErrorDataLengthExceedsMaximum
NSURLErrorDataLengthExceedsMaximum	The file operation failed because the file is too large.
SSL Errors

-1200
kCFURLErrorSecureConnectionFailed
NSURLErrorSecureConnectionFailed	The secure connection failed for an unknown reason.
-1201
kCFURLErrorServerCertificateHasBadDate
NSURLErrorServerCertificateHasBadDate	The secure connection failed because the server’s certificate has an invalid date.
-1202
kCFURLErrorServerCertificateUntrusted
NSURLErrorServerCertificateUntrusted	The secure connection failed because the server’s certificate is not trusted.
-1203
kCFURLErrorServerCertificateHasUnknownRoot
NSURLErrorServerCertificateHasUnknownRoot	The secure connection failed because the server’s certificate has an unknown root.
-1204
kCFURLErrorServerCertificateNotYetValid
NSURLErrorServerCertificateNotYetValid	The secure connection failed because the server’s certificate is not yet valid.
-1205
kCFURLErrorClientCertificateRejected
NSURLErrorClientCertificateRejected	The secure connection failed because the client’s certificate was rejected.
-1206
kCFURLErrorClientCertificateRequired
NSURLErrorClientCertificateRequired	The secure connection failed because the server requires a client certificate.
Download and File I/O Errors

-2000
kCFURLErrorCannotLoadFromNetwork
NSURLErrorCannotLoadFromNetwork	The connection failed because it is being required to return a cached resource, but one is not available.
-3000
kCFURLErrorCannotCreateFile
NSURLErrorCannotCreateFile	The file cannot be created.
-3001
kCFURLErrorCannotOpenFile
NSURLErrorCannotOpenFile	The file cannot be opened.
-3002
kCFURLErrorCannotCloseFile
NSURLErrorCannotCloseFile	The file cannot be closed.
-3003
kCFURLErrorCannotWriteToFile
NSURLErrorCannotWriteToFile	The file cannot be written.
-3004
kCFURLErrorCannotRemoveFile
NSURLErrorCannotRemoveFile	The file cannot be removed.
-3005
kCFURLErrorCannotMoveFile
NSURLErrorCannotMoveFile	The file cannot be moved.
-3006
kCFURLErrorDownloadDecodingFailedMidStream
NSURLErrorDownloadDecodingFailedMidStream	The download failed because decoding of the downloaded data failed mid-stream.
-3007
kCFURLErrorDownloadDecodingFailedToComplete
NSURLErrorDownloadDecodingFailedToComplete	The download failed because decoding of the downloaded data failed to complete.
Cookie errors

-4000
kCFHTTPCookieCannotParseCookieFile	The cookie file cannot be parsed.
CFNetServices Errors

-72000L
kCFNetServiceErrorUnknown	An unknown error occurred.
-72001L
kCFNetServiceErrorCollision	An attempt was made to use a name that is already in use.
-72002L
kCFNetServiceErrorNotFound	Not used.
-72003L
kCFNetServiceErrorInProgress	A new search could not be started because a search is already in progress.
-72004L
kCFNetServiceErrorBadArgument	A required argument was not provided or was not valid.
-72005L
kCFNetServiceErrorCancel	The search or service was cancelled.
-72006L
kCFNetServiceErrorInvalid	Invalid data was passed to a CFNetServices function.
-72007L
kCFNetServiceErrorTimeout	A search failed because it timed out.
-73000L
kCFNetServiceErrorDNSServiceFailure	An error from DNS discovery; look at kCFDNSServiceFailureKey to get the error number and interpret using dnssd.h
 */

@end
