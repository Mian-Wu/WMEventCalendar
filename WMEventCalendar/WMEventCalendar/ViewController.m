//
//  ViewController.m
//  WMEventCalendar
//
//  Created by 吴冕 on 2018/4/12.
//  Copyright © 2018年 wumian. All rights reserved.
//

#import "ViewController.h"
#import "WMEventCalendarTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[WMEventCalendarTool sharedEventCalendar] checkCalendarCanUsedCompletion:^(BOOL granted, NSError *error) {
        //        // 添加
        //        [[WMEventCalendar sharedEventCalendar] createEventCalendarTitle:@"测试日历提醒01" addLocation:@"" addStartDate:[NSDate new] addEndDate:[[NSDate new] dateByAddingTimeInterval:10000] addAllDay:NO addAlarmArray:@[@"300"] addCompletion:^(BOOL granted, NSError *error) {
        //            if (error) {
        //                NSLog(@"%@",error.description);
        //            }else{
        //                NSLog(@"成功");
        //            }
        //        }];
        //        [[WMEventCalendar sharedEventCalendar] createEventCalendarTitle:@"测试日历提醒02" addLocation:@"" addStartDate:[NSDate new] addEndDate:[[NSDate new] dateByAddingTimeInterval:10000] addAllDay:NO addAlarmArray:@[@"300"] addCompletion:^(BOOL granted, NSError *error) {
        //            if (error) {
        //                NSLog(@"%@",error.description);
        //            }else{
        //                NSLog(@"成功");
        //            }
        //        }];
        //        [[WMEventCalendar sharedEventCalendar] createEventCalendarTitle:@"测试日历提醒03" addLocation:@"" addStartDate:[NSDate new] addEndDate:[[NSDate new] dateByAddingTimeInterval:10000] addAllDay:NO addAlarmArray:@[@"300"] addCompletion:^(BOOL granted, NSError *error) {
        //            if (error) {
        //                NSLog(@"%@",error.description);
        //            }else{
        //                NSLog(@"成功");
        //            }
        //        }];
        //         修改
        //                [[WMEventCalendar sharedEventCalendar] modifyCalendarCalendarTitle:@"测试日历提醒04" addLocation:@"" addModifytitle:@"测试日历提醒01" addStartDate:[[NSDate new] dateByAddingTimeInterval:-1000] addEndDate:[[NSDate new] dateByAddingTimeInterval:100000] addAllDay:NO addAlarmArray:nil addCompletion:^(BOOL granted, NSError *error) {
        //                                if (error) {
        //                                    NSLog(@"%@",error.description);
        //                                }else{
        //                                    NSLog(@"成功");
        //                                }
        //                }];
        
        // 删除
        //               BOOL issucess = [[WMEventCalendar sharedEventCalendar] deleteCalendarStartDate:[[NSDate new] dateByAddingTimeInterval:-1000] addEndDate:[[NSDate new] dateByAddingTimeInterval:100000] addModifytitle:@""];
        //                NSLog(@"%zd",issucess);
        //                NSArray *array = [[WMEventCalendar sharedEventCalendar] checkToStartDate:[[NSDate new] dateByAddingTimeInterval:-1000] addEndDate:[[NSDate new] dateByAddingTimeInterval:100000] addModifytitle:@""];
        //                for (int i = 0; i < array.count ; i++) {
        //                    EKEvent *event = array[i];
        //                    NSLog(@"%@",event.title);
        //                }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
