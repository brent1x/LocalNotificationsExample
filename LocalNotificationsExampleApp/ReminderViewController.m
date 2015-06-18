//
//  ReminderViewController.m
//  LocalNotificationsExampleApp
//
//  Created by Brent Dady on 6/17/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import "ReminderViewController.h"
#import "AppDelegate.h"

@interface ReminderViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property NSArray *notifications;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Create Reminder";

    UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
}

- (IBAction)setReminder:(id)sender {

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = self.datePicker.date;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = @"Time to drink some water.";
    localNotification.soundName = @"water.aiff";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    self.notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

    UILocalNotification *notificationToLog = [self.notifications lastObject];
    NSLog(@"%@", notificationToLog.fireDate);

    // NSLog(@"number: %lu", (unsigned long)self.notifications.count);
}

- (void)killAllNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    UILocalNotification *notification = [self.notifications objectAtIndex:indexPath.row];
    NSLog(@"%lu", (unsigned long)self.notifications.count);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", notification.fireDate.description];
    return cell;
}

@end
