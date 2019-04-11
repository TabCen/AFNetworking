//
//  ViewController.m
//  iOSSingleNetworking
//
//  Created by David on 2019/4/8.
//

#import "ViewController.h"

@import AFNetworking;

@interface ViewController ()<NSURLSessionDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    ///测试URL
    
//    [self request_NSURLConnection];
//    [self request_NSURLSession];
    
    /// 使用AFN 网络请求测试
    [self request_AFN];
    
}


- (void)request_AFN{
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    NSURLSessionDataTask *task = [manager GET:@"/users/TabCen?" parameters:@{@"client_id": ClientID,@"client_secret":ClientSecret} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"网络请求成功");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
    
    [task resume];
}



///原生网络请求

- (void)request_NSURLConnection{
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.github.com/users/TabCen?client_id=%@&client_secret=%@",ClientID,ClientSecret];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"网络响应：%@",response);
        NSLog(@"DATA：%@",data);
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",str);
        
    }];
    
}

- (void)request_NSURLSession{

    NSString *urlStr = [NSString stringWithFormat:@"https://api.github.com/users/TabCen?client_id=%@&client_secret=%@",ClientID,ClientSecret];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    ///NSURLSession三部曲
    ///1、创建 Configuration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    ///2、创建 Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    ///3、创建 Task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"网络响应：%@",response);
        NSLog(@"DATA：%@",data);
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",str);
    }];
    
    [task resume];
    
}

#pragma mark - 代理

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error{
    if (error) {
        NSLog(@"Session become Invalid—— error:%@",error);
    }else{
        NSLog(@"Session become Invalid—— Normal");
    }
}

//If implemented, when a connection level authentication challenge has occurred, this delegate will be given the opportunity to provide authentication credentials to the underlying connection. Some types of authentication will apply to more than one request on a given connection to a server (SSL Server Trust challenges).  If this delegate message is not implemented, the behavior will be to use the default handling, which may involve user interaction.


/**
 如果实现了，当发生连接级别身份验证挑战时，该委托将有机会向基础连接提供身份验证凭据。某些类型的身份验证将应用于到服务器的给定连接上的多个请求(SSL服务器信任挑战)。如果未实现此委托消息，则行为将使用默认处理，这可能涉及用户交互。
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session API_AVAILABLE(ios(7.0), watchos(2.0), tvos(9.0)) API_UNAVAILABLE(macos){
    
}


@end
