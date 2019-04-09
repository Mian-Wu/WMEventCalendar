//
//  WMEventCalendarTool.m
//  WMEventCalendar
//
//  Created by 吴冕 on 2018/4/12.
//  Copyright © 2018年 wumian. All rights reserved.
//

#import "WMEventCalendarTool.h"

@interface WMEventCalendarTool()

@property (nonatomic ,copy) completion  completion;

@property (nonatomic, strong) EKEventStore *eventStore;

@end

@implementation WMEventCalendarTool

+ (instancetype)sharedEventCalendar{
    static WMEventCalendarTool *eventCalendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        eventCalendar = [[WMEventCalendarTool alloc] init];
        eventCalendar.eventStore = [[EKEventStore alloc] init];
    });
    return eventCalendar;
    
}

// 检测日历功能是否可以使用
- (void)checkCalendarCanUsedCompletion:(completion)completion{
    //    EKEntityTypeEvent日历事件
    //    EKEntityTypeReminder提醒事项
    self.completion = completion;
    EKAuthorizationStatus eventStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    if (eventStatus == EKAuthorizationStatusAuthorized) {
        // 已授权，可使用
        if (self.completion) {
            self.completion(YES, nil);
        }
    }else if(eventStatus == EKAuthorizationStatusNotDetermined){
        // 未进行授权选择
        __block  BOOL isGranted = NO;
        __block  NSError *isError;
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            isGranted = granted;
            isError = error;
            if (granted) {
                NSLog(@"用户点击了允许访问日历");
            }else{
                NSLog(@"用户没有点允许访问日历");
            }
            if(self.completion){
                self.completion(isGranted, isError);
            }
        }];
    }else{
        // 未授权
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:@{NSLocalizedDescriptionKey : @"未授权"}];
        if (self.completion) {
            self.completion(NO, error);
        }
    }
}

/**
 *  添加日历源
 *
 *  @param calendarIdentifier  日历源ID(标识符，用于区分日历源)
 *  @param title      日历源标题
 *  @param completion 回调方法
 */
- (void)createCalendarIdentifier:(NSString *)calendarIdentifier addCalendarTitle:(NSString *)title addCompletion:(completion)completion{
    self.completion = completion;
    NSError *error;
    BOOL isSuccess = NO;
    EKSource *localSource;
    for (EKSource *source in self.eventStore.sources){
        if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"]){
            localSource = source;
            break;
        }
    }
    if (localSource == nil){
        for (EKSource *source in self.eventStore.sources){
            if (source.sourceType == EKSourceTypeLocal){
                localSource = source;
                break;
            }
        }
    }
    EKCalendar *eventCalendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self.eventStore];
    eventCalendar.source = localSource;
    eventCalendar.title = title;
    isSuccess = [self.eventStore saveCalendar:eventCalendar commit:YES error:&error];
    if (!error) {
        if (eventCalendar.calendarIdentifier && ![eventCalendar.calendarIdentifier isEqualToString:@""] && calendarIdentifier && ![calendarIdentifier isEqualToString:@""]) {
            //存储日历ID
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:eventCalendar.calendarIdentifier forKey:calendarIdentifier];
            isSuccess = [userDefaults synchronize];
            if (!isSuccess) {
                error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileWriteUnknownError userInfo:@{NSLocalizedDescriptionKey : @"存储失败"}];
            }
        }else{
            error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileWriteUnknownError userInfo:@{NSLocalizedDescriptionKey : @"eventIdentifier不存在"}];
        }
    }
    if (self.completion) {
        self.completion(isSuccess, error);
    }
}

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
- (void)createEventIdentifier:(NSString *)eventIdentifier addCalendarTitle:(NSString *)title addLocation:(NSString *)location addStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addAllDay:(BOOL)allDay addAlarmArray:(NSArray *)alarmArray addNotes:(NSString *)notes addURL:(NSURL *)url addCalendarIdentifier:(NSString *)calendarIdentifier addCompletion:(completion)completion{
    self.completion = completion;
    __block  BOOL isGranted = NO;
    __block  NSError *isError;
    if ([self.eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]){
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
            isGranted = granted;
            isError = error;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isError){
                    if (self.completion) {
                        self.completion(isGranted,isError);
                    }
                }else if (!isGranted){
                    if (self.completion) {
                        self.completion(isGranted,isError);
                    }
                }else{
                    EKEvent *event  = [EKEvent eventWithEventStore:self.eventStore];
                    event.title = title;
                    event.location = location;
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = startDate;
                    event.endDate   = endDate;
                    // 是否设置全天
                    event.allDay = allDay;
                    if (notes && ![notes isEqualToString:@""]) {
                        event.notes = notes;
                    }
                    if(url){
                        event.URL = url;
                    }
                    //添加提醒
                    if (alarmArray && alarmArray.count > 0) {
                        for (NSString *timeString in alarmArray) {
                            [event addAlarm:[EKAlarm alarmWithRelativeOffset:[timeString integerValue]]];
                            
                        }
                    }
                    // 存储到源中
                    EKCalendar *eventCalendar;
                    NSString *cIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:calendarIdentifier];
                    if (cIdentifier && ![cIdentifier isEqualToString:@""]) {
                        NSArray *tempA = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
                        for (int i = 0 ; i < tempA.count; i ++) {
                            EKCalendar *temCalendar = tempA[i];
                            if ([temCalendar.calendarIdentifier isEqualToString:cIdentifier]) {
                                eventCalendar = temCalendar;
                            }
                        }
                    }
                    if (eventCalendar) {
                        [event setCalendar:eventCalendar];
                    }else{
                        [event setCalendar:[self.eventStore defaultCalendarForNewEvents]];
                    }
                    
                    // 保存日历
                    [self.eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&isError];
                    if (!isError) {
                        if (event.eventIdentifier && ![event.eventIdentifier isEqualToString:@""] && eventIdentifier && ![eventIdentifier isEqualToString:@""]) {
                            //存储日历ID
                            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                            [userDefaults setObject:event.eventIdentifier forKey:eventIdentifier];
                            isGranted = [userDefaults synchronize];
                            if (!isGranted) {
                                isError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileWriteUnknownError userInfo:@{NSLocalizedDescriptionKey : @"存储失败"}];
                            }
                        }else{
                            isError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileWriteUnknownError userInfo:@{NSLocalizedDescriptionKey : @"eventIdentifier不存在"}];
                        }
                    }
                    if (self.completion) {
                        self.completion(isGranted,isError);
                    }
                }
            });
        }];
    }
}

/**
 *  查日历事件
 *
 *  @param eventIdentifier    事件ID(标识符)
 */
- (EKEvent *)checkToEventIdentifier:(NSString *)eventIdentifier{
    NSString *eIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:eventIdentifier];
    if (eIdentifier && ![eIdentifier isEqualToString:@""]) {
        EKEvent *event = [self.eventStore eventWithIdentifier:eIdentifier];
        return event;
    }
    return nil;
}

/**
 *  查日历事件(可查询一段时间内的事件)
 *
 *  @param startDate  开始时间
 *  @param endDate    结束时间
 *  @param modifytitle    标题，为空则都要查询
 *  @param calendarIdentifier  事件源(无，则为默认)
 */
- (NSArray *)checkToStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addModifytitle:(NSString *)modifytitle addCalendarIdentifier:(NSString *)calendarIdentifier{
    
    // 查询到所有的日历
    NSArray *tempA = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    NSMutableArray *only3D = [NSMutableArray array];
    
    for (int i = 0 ; i < tempA.count; i ++) {
        
        EKCalendar *temCalendar = tempA[i];
        EKCalendarType type = temCalendar.type;
        // 工作、家庭和本地日历
        if (type == EKCalendarTypeLocal || type == EKCalendarTypeCalDAV)  {
            if (calendarIdentifier && ![calendarIdentifier isEqualToString:@""]) {
                NSString *cIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:calendarIdentifier];
                if ([temCalendar.calendarIdentifier isEqualToString:cIdentifier]){
                    [only3D addObject:temCalendar];
                }
            }else{
                [only3D addObject:temCalendar];
            }
        }
    }
    
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:only3D];
    
    // 获取到范围内的所有事件
    NSArray *request = [self.eventStore eventsMatchingPredicate:predicate];
    // 按开始事件进行排序
    request = [request sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    
    if (!modifytitle || [modifytitle isEqualToString:@""]) {
        return request;
    }else{
        NSMutableArray *onlyRequest = [NSMutableArray array];
        for (int i = 0; i < request.count; i++) {
            EKEvent *event = request[i];
            if (event.title && [event.title isEqualToString:modifytitle]) {
                [onlyRequest addObject:event];
            }
        }
        return onlyRequest;
    }
}

/**
 *  删除日历事件(删除单个)
 *
 *  @param eventIdentifier    事件ID(标识符)
 */
- (BOOL)deleteCalendarEventIdentifier:(NSString *)eventIdentifier{
    NSString *eIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:eventIdentifier];
    EKEvent *event;
    NSError*error =nil;
    if (eIdentifier && ![eIdentifier isEqualToString:@""]) {
        event = [self.eventStore eventWithIdentifier:eIdentifier];
        return [self.eventStore removeEvent:event span:EKSpanThisEvent error:&error];
    }
    return NO;
}


/**
 *  删除日历事件(可删除一段时间内的事件)
 *
 *  @param startDate  开始时间
 *  @param endDate    结束时间
 *  @param modifytitle    标题，为空则都要删除
 *  @param calendarIdentifier  事件源(无，则为默认)
 */
- (BOOL)deleteCalendarStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addModifytitle:(NSString *)modifytitle addCalendarIdentifier:(NSString *)calendarIdentifier{
    // 获取到此事件
    NSArray *request = [self checkToStartDate:startDate addEndDate:endDate addModifytitle:modifytitle addCalendarIdentifier:calendarIdentifier];
    
    for (int i = 0; i < request.count; i ++) {
        // 删除这一条事件
        EKEvent *event = request[i];
        NSError*error =nil;
        
        // commit:NO：最后再一次性提交
        [self.eventStore removeEvent:event span:EKSpanThisEvent commit:NO error:&error];
    }
    //一次提交所有操作到事件库
    NSError *errored = nil;
    BOOL commitSuccess= [self.eventStore commit:&errored];
    return commitSuccess;
}

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
 *  @param cIdentifier 修改事件源(传nil，则为默认)
 *  @param completion 回调方法
 */
- (void)modifyEventIdentifier:(NSString *)eventIdentifier addTitle:(NSString *)title addLocation:(NSString *)location addStartDate:(NSDate *)startDate addEndDate:(NSDate *)endDate addAllDay:(BOOL)allDay addAlarmArray:(NSArray *)alarmArray addNotes:(NSString *)notes addURL:(NSURL *)url addCIdentifier:(NSString *)cIdentifier addCompletion:(completion)completion{
    // 获取到此事件
    EKEvent *event = [self checkToEventIdentifier:eventIdentifier];
    if (event) {
        [self deleteCalendarEventIdentifier:eventIdentifier];
        
        [self createEventIdentifier:eventIdentifier addCalendarTitle:title addLocation:location addStartDate:startDate addEndDate:endDate addAllDay:allDay addAlarmArray:alarmArray addNotes:notes addURL:url addCalendarIdentifier:cIdentifier addCompletion:completion];
    }else{
        // 没有此条日历
        [self createEventIdentifier:eventIdentifier addCalendarTitle:title addLocation:location addStartDate:startDate addEndDate:endDate addAllDay:allDay addAlarmArray:alarmArray addNotes:notes addURL:url addCalendarIdentifier:cIdentifier addCompletion:completion];
    }
}


@end
