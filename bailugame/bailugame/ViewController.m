//
//  ViewController.m
//  bailugame
//
//  Created by 闫佳奇 on 17/3/17.
//  Copyright © 2017年 egretteam. All rights reserved.
//

#import "ViewController.h"
#import "MZInitialObject.h"
#import "MZIAPManager.h"
#import "MZManager.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.gameView = [[BailuGameView alloc] initWithSuperView:self.view];
//    NSString *strURL = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSURL *url = [[NSURL alloc] initFileURLWithPath:strURL];
    
//==    NSString* strURL = @"http://wan.yichi666.com/go.php";
    NSString* strURL = @"http://api.egret-labs.org/v2/game/22698/91284";
    NSString* param = [self getParams];
    strURL = [strURL stringByAppendingString:param];
    NSURL* url = [NSURL URLWithString:strURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.gameView.mWebView loadRequest:request];
    
    self.navigation = [[Navigation alloc] initWithSuperView:self.view WebView:self.gameView];
    //拇指游玩
    [[MZManager shareInstance] setUiViewController:self];
    
//    //调用登录接口
//    [[MZInitialObject shareInitialObject] mz_LoginWithGameId:@"391" packetId:@"100391001" testModel:YES loginResult:^(NSString *ACCOUNT_ID, NSString *LOGIN_ACCOUNT, NSString *sign) {
//        
//        NSLog(@"%@==%@==%@", ACCOUNT_ID, LOGIN_ACCOUNT, sign);
//        
//    }];
    
    NSLog(@"%@", strURL);
}

- (NSString*)getParams
{
//    UIDevice* device = [UIDevice currentDevice];
    
//    NSString* ret = [NSString stringWithFormat:@"?url=FreeGame&network=%@&brand=%@&model=%@&deviceId=%@&imei=%@&imsi=%@&mac=%@&wd=1",
//                     [self getNetwork], @"Apple", [device model], [[device identifierForVendor] UUIDString],
//                     @"unknown", @"unknown", @"unknown"];
//    ret = [ret stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString* ret = @"?egretPlat=ios_micro";
    
    
    
    return ret;
}

- (NSString*)getNetwork
{
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"unknown";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

-(void)viewWillAppear:(BOOL)animated{
  
   [_gameView resetMessageHandler];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_gameView removeMessageHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
