//
//  main.m
//  block_demo
//
//  Created by 鹏鹏 on 2016/12/26.
//  Copyright © 2016年 Xuanxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *(^BLOCK)(void);
typedef void(^BLOCK2)(NSString *);
typedef NSString *(^BLOCK3)(NSString *);
typedef void(^BLOCK4)(void);

//全局变量
NSInteger globalNum = 100;

void (^aBlock)(int) = ^(int num){
    NSLog(@"int number is %d",num);
};

//block 排序
void blockCompare(){
    NSArray *arr = @[@"iphone", @"Android", @"Samsung", @"Kokia"];
    
    //block排序
    NSArray *newArr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return -[obj1 compare:obj2];
    }];
    NSLog(@"%@",newArr);
    
    //可变数组
    NSMutableArray *mArr = [arr mutableCopy];
    //排序
    [mArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"%@",mArr);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //int a = 100;
        //void (^) (void)    -> int
        //block1             -> a
        //^(void){}          -> 100
        
        //1.无参无返回值
        void (^block1)(void) = ^(void){
            NSLog(@"这是一个无参无返回值的block");
        };
        block1();
        
        //2.有参无返回值
        void (^block2)(NSString *) = ^(NSString *string){
            NSLog(@"有参无返回值block, 参数是:%@",string);
        };
        block2(@"一个参数");
        //3.无参有返回值
        NSString *(^block3)(void) = ^(void){
//            NSLog(@"无参有返回值block");
            return [NSString stringWithFormat:@"%@",@"无参有返回值block"];
   
            
        };
//        block3();
        NSLog(@"%@", block3());
//        NSLog(@"%@", block1);
//        NSLog(@"%@",block2);
        //4.有参有返回值
        NSString *(^block4)(NSDictionary *) = ^(NSDictionary *dic){
            return dic.allKeys[0];
        };
//        block4(@{@"我是key":@"我是value"});
        NSLog(@"%@",block4(@{@"我是key":@"我是value"}));
        
        __block NSInteger localNum  = 100;
        //block重定义
        //局部变量在block中只能读取 不能修改
        //可以在局部变量前面添加__block 使局部变量可以被修改
        BLOCK block5 = ^(){
//            NSLog(@"%ld",localNum);
            localNum ++;
            globalNum ++;
            return @"block重定义-无参有返回值";
        };
        NSLog(@"%@",block5());
        NSLog(@"%ld-%ld",localNum, globalNum);
        
        BLOCK2 block6 = ^(NSString *parameter){
            NSLog(@"block重定义-有参无返回值-参数为:%@",parameter);
        };
        block6(@"666");
        
        aBlock(10);
        
        blockCompare();
        
    }
    return 0;
}




