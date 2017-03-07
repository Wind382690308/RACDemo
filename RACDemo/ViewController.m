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

@property (nonatomic,strong) UITextField * TextField;

@property (nonatomic,strong) UITextField * TextField1;

@property (nonatomic,strong) UIButton * loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //是什么
    //uite ·原理是什么
    //怎么学习
    //需要注意或者要提醒的是
    
    UITextField * TextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, 200, 40)];
    
    TextField.borderStyle = UITextBorderStyleLine;
    
    TextField.placeholder = @"请输入账号";
    
    [self.view addSubview:TextField];
    
    _TextField = TextField;
    
    UITextField * passwordField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 200, 40)];
    
    passwordField.borderStyle = UITextBorderStyleLine;
    
    passwordField.placeholder = @"请输入密码";
    
    [self.view addSubview:passwordField];
    
    _TextField1 = passwordField;
    
    
    UIButton * loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginBt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    
    [loginBt setTitle:@"登录" forState:UIControlStateDisabled];
    
    [loginBt setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateDisabled];
    
    loginBt.frame = CGRectMake(30, 200, 200, 40);
    
    [self.view addSubview:loginBt];
    
    _loginBtn = loginBt;
    //RAC
    
    //textFild的文字更改监听
   
//    [[TextField rac_textSignal] subscribeNext:^(id x) {
//        
//     
//        NSLog(@"***text   %@",x);
//        
//    }];
//    
//    //通知可见，notification.object就是我们想要的数组，当然我们也可以传一些model。值得一提的是，RAC中的通知不需要remove observer，因为在rac_add方法中他已经写了remove。
//    
//    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"touchesBegan" object:nil] subscribeNext:^(NSNotification* x) {
//        
//         NSLog(@"***defaultCenter   %@",x);
//    }];
//
//    
//    // kvo RAC中得KVO大部分都是宏定义，所以代码异常简洁，简单来说就是RACObserve(TARGET, KEYPATH)这种形式，TARGET是监听目标，KEYPATH是要观察的属性值，这里举一个很简单的例子，如果UIScrollView滚动则输出success。
//    //RACObserve使用了KVO来监听property的变化，只要username被自己或外部改变，block就会被执行。但不是所有的property都可以被RACObserve，该property必须支持KVO，比如NSURLCache的currentDiskUsage就不能被RACObserve。
//    
//    [RACObserve(TextField, textColor) subscribeNext:^(id x) {
//        
//          NSLog(@"***RACObserve   %@",x);
//        
//    }];
//    
//    
//    TextField.textColor =  [UIColor redColor];
//    
//    
//    sleep(2);
//    
//    TextField.textColor = [UIColor blueColor];
//    
//    
//    //新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。
//    [[[TextField.rac_textSignal map:^id(NSString* value) {
//        
//        return @(value.length);
//    }] filter:^BOOL(NSString* value) {
//        
//        return [value integerValue]>3;
//    }] subscribeNext:^(id x) {
//        
//        NSLog(@"map  %@" , x);
//    }];
//
//    
//    
////    RAC(loginBt,enabled) = [RACSignal combineLatest:@[TextField.rac_textSignal,passwordField.rac_textSignal] reduce:^id(NSString*tet1,NSString*tet2){
////        
////        return @(tet1.length>0&&tet2.length>0?YES:NO);
////    }];
//    
//    //或者 上一个要更好一点
//    
//    RAC(loginBt,enabled) = [RACSignal combineLatest:@[RACObserve(TextField, text),RACObserve(passwordField, text)] reduce:^id(NSString*tet1,NSString*tet2){
//       
//        return @(tet1.length>0&&tet2.length>0);
//        
//    }];
//    
//    @weakify(self);
//    [[loginBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//       
//        NSLog(@"点击了登录");
//        
//        @strongify(self);
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
//        //
//        //    //这里block中有一个RACTuple，他相当于是一个集合类
//        [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
//            NSLog(@"%@",tuple.first);
//            
//            NSLog(@"%@",tuple.second);
//            
//            NSLog(@"%@",tuple.third);
//        }];
//        
//        [alertView show];
//        
//    }];
    
//    [[TextField.rac_textSignal filter:^BOOL(id value) {
//        
//        NSString * valueStr = value;
//        
//        return valueStr.length>3;
//   
//    }] subscribeNext:^(id x) {
//        
//        NSLog(@"text %@",x);
//        
//    }];
    
    //新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。
   // 注意：在上面的例子中text.length返回一个NSUInteger，是一个基本类型。为了将它作为事件的内容，NSUInteger必须被封装。幸运的是Objective-C literal syntax提供了一种简单的方法来封装——@ (text.length)。
//    [[[TextField.rac_textSignal map:^id(NSString* value) {
//     
//        return @(value.length);
//        
//    }]filter:^BOOL(NSNumber* value) {
//        
//        return [value integerValue]>3;
//    }]subscribeNext:^(id x) {
//        
//        NSLog(@"number  %@",x);
//    }];
    
    RACSignal * validSignal = [TextField.rac_textSignal map:^id(NSString* value) {
        
        return @([self isValidUsername:value]);
    }];
    
    RACSignal * validSignal2 = [passwordField.rac_textSignal map:^id(NSString* value) {
        
        return @([self isValidUsername:value]);
    }];
    
    //RAC宏允许直接把信号的输出应用到对象的属性上。RAC宏有两个参数，第一个是需要设置属性值的对象，第二个是属性名。每次信号产生一个next事件，传递过来的值都会应用到该属性上。
    
//    上面的代码使用combineLatest:reduce:方法把validUsernameSignal和validPasswordSignal产生的最新的值聚合在一起，并生成一个新的信号。每次这两个源信号的任何一个产生新值时，reduce block都会执行，block的返回值会发给下一个信号。
    
//    RAC(TextField,backgroundColor) = [ validSignal map:^id(NSNumber* value) {
//        
//        return  [value boolValue]?[UIColor redColor]:[UIColor blueColor];
//    }];
//    
//    RAC(passwordField,backgroundColor)=[validSignal2 map:^id(NSNumber* value) {
//        
//        return [value boolValue]?[UIColor redColor] :[UIColor blueColor];
//    }];
    
    [[RACSignal combineLatest:(@[validSignal,validSignal2]) reduce:^id(NSNumber*num1,NSNumber*num2){
        
        return @([num1 boolValue]&&[num2 boolValue]);
    
    }]subscribeNext:^(id x) {
        
        loginBt.enabled = [x boolValue];
        
    }];
    
//    [RACObserve(loginBt, enabled) subscribeNext:^(id x) {
//        
//        NSLog(@"变化了  %@",x);
//    }];
    
    //这个操作把按钮点击事件转换为登录信号，同时还从内部信号发送事件到外部信号。
//    [[[loginBt rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^id(id value) {
//    
//        NSLog(@"btn click  ");
//        
//        return [self signInSignal];
//
//    }] subscribeNext:^(id x) {
//        
//         NSLog(@"btn resoult  %@", [x boolValue]?@"yes":@"no");
//    }];
    
    //你可以看到doNext:是直接跟在按钮点击事件的后面。而且doNext: block并没有返回值。因为它是附加操作，并不改变事件本身。
    
    
    
//    上面的doNext: block把按钮置为不可点击，隐藏登录失败提示。然后在subscribeNext: block里重新把按钮置为可点击，并根据登录结果来决定是否显示失败提示。
//    
//    [[[[loginBt rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
//        
//        loginBt.enabled = NO;
//        
//        NSLog(@"登录点击");
//        
//    }] flattenMap:^RACStream *(id value) {
//       
//        NSLog(@"正在登录");
//        return [self signInSignal];
//        
//    }] subscribeNext:^(id x) {
//        
//        loginBt.enabled = YES;
//        
//        NSLog(@"登录成功");
//        
//    }];
    
    
//    在本系列教程的第二部分，你将会学到一些ReactiveCocoa的高级功能，包括：
//    
//    另外两个事件类型：error 和 completed
//    节流
//    线程
//    延伸
//    其他
    
    
    [[[self.TextField.rac_textSignal map:^id(NSString* value) {
     
        return [self isValidSearchText:value]?[UIColor redColor]:[UIColor orangeColor];
    }]subscribeNext:^(UIColor* x) {
        
        self.TextField.textColor = x;
    }] dispose];
    
    //如何取消订阅一个signal？在一个completed或者error事件之后，订阅会自动移除（马上就会讲到）。你还可以通过RACDisposable 手动移除订阅。
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
}

//上面的代码使用RACSignal的createSignal:方法来创建信号。方法的入参是一个block，这个block描述了这个信号。当这个信号有subscriber时，block里的代码就会执行。
//
//block的入参是一个subscriber实例，它遵循RACSubscriber协议，协议里有一些方法来产生事件，你可以发送任意数量的next事件，或者用error\complete事件来终止。本例中，信号发送了一个next事件来表示登录是否成功，随后是一个complete事件。
//
//这个block的返回值是一个RACDisposable对象，它允许你在一个订阅被取消时执行一些清理工作。当前的信号不需要执行清理操作，所以返回nil就可以了。
-(RACSignal*)signInSignal{

   return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
       [self signInWithUsername:self.TextField.text password:self.TextField1.text complete:^(BOOL success) {
          
           [subscriber sendNext:@(success)];
           
           [subscriber sendCompleted];
       }];
      
       return nil;
   }];
    
}

typedef void (^RWSignInResponse)(BOOL);


- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock{

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [username isEqualToString:@"User"] && [password isEqualToString:@"Password"];
        completeBlock(success);
    });
}



-(BOOL)isValidUsername:(NSString*)str{

    return str.length>0;
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
