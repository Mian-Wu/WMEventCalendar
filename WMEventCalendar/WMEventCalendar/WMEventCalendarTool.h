//
//  WMEventCalendarTool.h
//  WMEventCalendar
//
//  Created by 吴冕 on 2018/4/12.
//  Copyright © 2018年 wumian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>

typedef void(^completion)(BOOL granted, NSError *error);

@interface WMEventCalendarTool : NSObject

+ (instancetype)sharedEventCalendar;

// 检测日历功能是否可以使用
- (void)checkCalendarCanUsedCompletion:(completion)completion;

/**
 *  添加日历源
 *
 *  @param calendarIdentifier  日历源ID(标识符，用于区分日历源)
 *  @param title      日历源标题
 *  @param completion 回调方法
 */
- (void)createCalendarIdentifier:(NSString *)calendarIdentifier addCalendarTitle:(NSString *)title addCompletion:(completion)completion;

/**
 *  添加日历提醒事项
 *
 *  @param eventIdentifier  事件ID(标识符，用于区分日历)
 *  @param title      事件标题
 *  @param location   事件位置
 *  @param startDate  开始时间
 *  @param endDate    结束时间
 *  @param allDay     是否全天
 *  @param alarmArray 闹钟集合(传nil，则没有)
 *  @param notes      事件备注(传nil，则没有)
 *  @param url        事件url(传nil，则没有)
 *  @param calendarIdentifier  事件源(无，则为默认)
 *  @param completion 回调方法
 */
- (void)createEventIdentifier:(NSString *)eventIdentifier addCalendarTitle:(NSString *)title addLocation:(NSString *)location addStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addAllDay:(BOOL)allDay addAlarmArray:(NSArray *)alarmArray addNotes:(NSString *)notes addURL:(NSURL *)url addCalendarIdentifier:(NSString *)calendarIdentifier addCompletion:(completion)completion;


/**
 *  查日历事件(单个)
 *
 *  @param eventIdentifier    事件ID(标识符)
 */
- (EKEvent *)checkToEventIdentifier:(NSString *)eventIdentifier;

/**
 *  查日历事件
 *
 *  @param startDate  开始时间
 *  @param endDate    结束时间
 *  @param modifytitle    标题，为空则都要查询
 *  @param calendarIdentifier  事件源(无，则为默认)
 */
- (NSArray *)checkToStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addModifytitle:(NSString *)modifytitle addCalendarIdentifier:(NSString *)calendarIdentifier;

/**
 *  删除日历事件(单个)
 *
 *  @param eventIdentifier    事件ID(标识符)
 */
- (BOOL)deleteCalendarEventIdentifier:(NSString *)eventIdentifier;

/**
 *  删除日历事件
 *
 *  @param startDate  开始时间
 *  @param endDate    结束时间
 *  @param modifytitle    标题，为空则都要删除
 *  @param calendarIdentifier  事件源(无，则为默认)
 */
- (BOOL)deleteCalendarStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addModifytitle:(NSString *)modifytitle addCalendarIdentifier:(NSString *)calendarIdentifier;

/**
 *  修改日历
 *
 *  @param eventIdentifier 事件ID(标识符)
 *  @param title      修改事件标题
 *  @param location   修改事件位置
 *  @param startDate  修改开始时间
 *  @param endDate    修改结束时间
 *  @param allDay     修改是否全天
 *  @param alarmArray 修改闹钟集合
 *  @param notes      修改事件备注
 *  @param url        修改事件url
 *  @param cIdentifier 修改事件源(无，则为默认)
 *  @param completion 回调方法
 */
- (void)modifyEventIdentifier:(NSString *)eventIdentifier addTitle:(NSString *)title addLocation:(NSString *)location addStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addAllDay:(BOOL)allDay addAlarmArray:(NSArray *)alarmArray addNotes:(NSString *)notes addURL:(NSURL *)url addCIdentifier:(NSString *)cIdentifier addCompletion:(completion)completion;

@end
