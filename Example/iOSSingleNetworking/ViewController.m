//
//  ViewController.m
//  iOSSingleNetworking
//
//  Created by David on 2019/4/8.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///测试URL
    //    https://api.github.com/users/TabCen?client_id=xxxx&client_secret=yyyy
    
    //    [self request_NSURLConnection];
    
    [self request_NSURLSession];
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
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"网络响应：%@",response);
        NSLog(@"DATA：%@",data);
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",str);
    }];
    
    [task resume];
    
}



@end
