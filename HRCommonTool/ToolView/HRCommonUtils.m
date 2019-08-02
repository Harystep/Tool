//
//  HRCommonUtils.m
//  HRCommonTool
//
//  Created by pxsl on 2019/7/30.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRCommonUtils.h"

@implementation HRCommonUtils

+ (void)loadLocalPath:(NSString *)path webView:(WKWebView *)webView {
    
    if(path){
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            
            // iOS9. One year later things are OK.
            NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",path]];
            [webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
            
        } else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
            // iOS8.0 以下的 走普通UIWebview
            NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",path]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [webView loadRequest:request];
            
        } else {
            // iOS8. Things can be workaround-ed
            NSURL *fileURL = [HRCommonUtils fileURLForBuggyWKWebView8:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",path]]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [webView loadRequest:request];
        }
    }
}
//iOS8之所以跟iOS9+系统加载方式不同，就差在这个路径。
+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    // 取到本地html后的锚点
    NSString *lastPathComponent = [[fileURL.absoluteString componentsSeparatedByString:@"/"] lastObject];
    NSURL *dstURL = [NSURL URLWithString:[temDirURL.absoluteString stringByAppendingString:lastPathComponent]];
    
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

@end
