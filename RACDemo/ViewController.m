//
//  ViewController.m
//  RACDemo
//
//  Created by windpc on 2017/2/6.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //uite
    
    UITextField * TextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, 200, 40)];
    
    TextField.borderStyle = UITextBorderStyleLine;
    
    TextField.placeholder = @"请输入账号";
    
    [self.view addSubview:TextField];
    
    UITextField * passwordField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 200, 40)];
    
    passwordField.borderStyle = UITextBorderStyleLine;
    
    passwordField.placeholder = @"请输入密码";
    
    [self.view addSubview:passwordField];
    
    
    UIButton * loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginBt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    
    [loginBt setTitle:@"登录" forState:UIControlStateDisabled];
    
    [loginBt setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateDisabled];
    
    loginBt.frame = CGRectMake(30, 200, 200, 40);
    
    [self.view addSubview:loginBt];
    
    //RAC
    
    //textFild的文字更改监听
   
    [[TextField rac_textSignal] subscribeNext:^(id x) {
        
     
        NSLog(@"***text   %@",x);
        
    }];
    
    //通知可见，notification.object就是我们想要的数组，当然我们也可以传一些model。值得一提的是，RAC中的通知不需要remove observer，因为在rac_add方法中他已经写了remove。
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"touchesBegan" object:nil] subscribeNext:^(NSNotification* x) {
        
         NSLog(@"***defaultCenter   %@",x);
    }];

    
    // kvo RAC中得KVO大部分都是宏定义，所以代码异常简洁，简单来说就是RACObserve(TARGET, KEYPATH)这种形式，TARGET是监听目标，KEYPATH是要观察的属性值，这里举一个很简单的例子，如果UIScrollView滚动则输出success。
    //RACObserve使用了KVO来监听property的变化，只要username被自己或外部改变，block就会被执行。但不是所有的property都可以被RACObserve，该property必须支持KVO，比如NSURLCache的currentDiskUsage就不能被RACObserve。
    
    [RACObserve(TextField, textColor) subscribeNext:^(id x) {
        
          NSLog(@"***RACObserve   %@",x);
        
    }];
    
    
    TextField.textColor =  [UIColor redColor];
    
    
    sleep(2);
    
    TextField.textColor = [UIColor blueColor];
    
    
    //新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。
    [[[TextField.rac_textSignal map:^id(NSString* value) {
        
        return @(value.length);
    }] filter:^BOOL(NSString* value) {
        
        return [value integerValue]>3;
    }] subscribeNext:^(id x) {
        
        NSLog(@"map  %@" , x);
    }];

    
    
//    RAC(loginBt,enabled) = [RACSignal combineLatest:@[TextField.rac_textSignal,passwordField.rac_textSignal] reduce:^id(NSString*tet1,NSString*tet2){
//        
//        return @(tet1.length>0&&tet2.length>0?YES:NO);
//    }];
    
    //或者 上一个要更好一点
    
    RAC(loginBt,enabled) = [RACSignal combineLatest:@[RACObserve(TextField, text),RACObserve(passwordField, text)] reduce:^id(NSString*tet1,NSString*tet2){
       
        return @(tet1.length>0&&tet2.length>0);
        
    }];
    
    @weakify(self);
    [[loginBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        NSLog(@"点击了登录");
        
        @strongify(self);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
        //
        //    //这里block中有一个RACTuple，他相当于是一个集合类
        [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
            NSLog(@"%@",tuple.first);
            
            NSLog(@"%@",tuple.second);
            
            NSLog(@"%@",tuple.third);
        }];
        
        [alertView show];
        
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
    NSLog(@"---  点击了  ");
    
    [[NSNotificationCenter defaultCenter ]postNotificationName:@"touchesBegan" object:touches];
    
    //代理
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
//    
//    //这里block中有一个RACTuple，他相当于是一个集合类
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
//        NSLog(@"%@",tuple.first);
//        
//        NSLog(@"%@",tuple.second);
//        
//        NSLog(@"%@",tuple.third);
//    }];
//    
//    [alertView show];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
