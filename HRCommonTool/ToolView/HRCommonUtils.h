//
//  HRCommonUtils.h
//  HRCommonTool
//
//  Created by pxsl on 2019/7/30.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HRCommonUtils : NSObject


/**
 *  打开本地网页
 *
 *  @param path 路径
 *  @param webView webView
 */
+ (void)loadLocalPath:(NSString *)path webView:(WKWebView *)webView;

/**
 *  将文件copy到tmp目录（wk打开本地网页的解决方法 8.0）wkwebview8.0系统，不支持加载本地html页面，所以需要用以下方法修复！！
 *
 *  @param fileURL fileURL
 *
 *  @ return
 */

+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL;

@end

NS_ASSUME_NONNULL_END
