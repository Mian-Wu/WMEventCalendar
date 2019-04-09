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
        // 添加日历源
        //            [[WMEventCalendarTool sharedEventCalendar] createCalendarIdentifier:@"EventCalendar_1" addCalendarTitle:@"行程" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
        
        //            [[WMEventCalendarTool sharedEventCalendar] createCalendarIdentifier:@"EventCalendar_2" addCalendarTitle:@"工作" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
        // 添加事件1 -4.4 - 1
        //            [[WMEventCalendarTool sharedEventCalendar] createEventIdentifier:@"EventIdentifier_01" addCalendarTitle:@"测试日历提醒01" addLocation:@"宇宙" addStartDate:[NSDate dateWithTimeIntervalSince1970:1554375207] addEndDate:[NSDate dateWithTimeIntervalSince1970:1554387007] addAllDay:NO addAlarmArray:@[@"300"] addNotes:@"测试日历提醒01的备注" addURL:[NSURL URLWithString:@"www.baidu.com"] addCalendarIdentifier:@"EventCalendar_1" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
        //             添加事件2 - 4.6 - 1
        //            [[WMEventCalendarTool sharedEventCalendar] createEventIdentifier:@"EventIdentifier_02" addCalendarTitle:@"测试日历提醒02" addLocation:@"世界" addStartDate:[NSDate dateWithTimeIntervalSince1970:1554533536] addEndDate:[NSDate dateWithTimeIntervalSince1970:1554562336] addAllDay:NO addAlarmArray:nil addNotes:nil addURL:nil addCalendarIdentifier:@"EventCalendar_1" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
        //            添加事件3 - 4.8 - 1
        //            [[WMEventCalendarTool sharedEventCalendar] createEventIdentifier:@"EventIdentifier_03" addCalendarTitle:@"测试日历提醒03" addLocation:@"亚洲" addStartDate:[NSDate dateWithTimeIntervalSince1970:1554699136] addEndDate:[NSDate dateWithTimeIntervalSince1970:1554735136] addAllDay:NO addAlarmArray:nil addNotes:nil addURL:nil addCalendarIdentifier:@"EventCalendar_1" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
        //              添加事件4 - 4.9 - 2
        //            [[WMEventCalendarTool sharedEventCalendar] createEventIdentifier:@"EventIdentifier_04" addCalendarTitle:@"测试日历提醒04" addLocation:@"中国" addStartDate:[NSDate dateWithTimeIntervalSince1970:1554785536] addEndDate:[NSDate dateWithTimeIntervalSince1970:1554807136] addAllDay:NO addAlarmArray:nil addNotes:nil addURL:nil addCalendarIdentifier:@"EventCalendar_2" addCompletion:^(BOOL granted, NSError *error) {
        //                                if (!error) {
        //                                    NSLog(@"成功");
        //                                }else{
        //                                    NSLog(@"%@",error.description);
        //                                }
        //                            }];
        //              添加事件5 - 4.10 - 2
        //            [[WMEventCalendarTool sharedEventCalendar] createEventIdentifier:@"EventIdentifier_05" addCalendarTitle:@"测试日历提醒05" addLocation:@"天安门" addStartDate:[NSDate dateWithTimeIntervalSince1970:1554857536] addEndDate:[NSDate dateWithTimeIntervalSince1970:1554893536] addAllDay:NO addAlarmArray:nil addNotes:nil addURL:nil addCalendarIdentifier:@"EventCalendar_2" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
        // 查询
        //            EKEvent *Events = [[WMEventCalendarTool sharedEventCalendar] checkToEventIdentifier:@"EventIdentifier_05"];
        //            NSArray *Events = [[WMEventCalendarTool sharedEventCalendar] checkToStartDate:[NSDate dateWithTimeIntervalSince1970:1554375207] addEndDate:[NSDate dateWithTimeIntervalSince1970:2554375207] addModifytitle:nil addCalendarIdentifier:@"EventCalendar_2"];
        //            for (int i = 0; i < Events.count; i++) {
        //                EKEvent *event = Events[i];
        //                NSLog(@"%@ - %@",event.title,event.eventIdentifier);
        //            }
        // 删除
        //            bool isSuceess = [[WMEventCalendarTool sharedEventCalendar] deleteCalendarEventIdentifier:@"EventIdentifier_04"];
        //            bool isSuceess = [[WMEventCalendarTool sharedEventCalendar] deleteCalendarStartDate:[NSDate dateWithTimeIntervalSince1970:1554375207] addEndDate:[NSDate dateWithTimeIntervalSince1970:2554375207] addModifytitle:nil addCalendarIdentifier:@"EventCalendar_2"];
        // 修改
        //            [[WMEventCalendarTool sharedEventCalendar] modifyEventIdentifier:@"EventIdentifier_04" addTitle:@"修改_测试日历提醒04" addLocation:@"长城" addStartDate:[NSDate dateWithTimeIntervalSince1970:1554955150] addEndDate:[NSDate dateWithTimeIntervalSince1970:1554980350] addAllDay:NO addAlarmArray:nil addNotes:nil addURL:nil addCIdentifier:@"EventCalendar_1" addCompletion:^(BOOL granted, NSError *error) {
        //                if (!error) {
        //                    NSLog(@"成功");
        //                }else{
        //                    NSLog(@"%@",error.description);
        //                }
        //            }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
