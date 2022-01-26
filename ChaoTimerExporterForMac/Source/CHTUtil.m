//
//  CHTUtil.m
//  ChaoTimer
//
//  Created by Jichao Li on 8/12/13.
//  Copyright (c) 2013 Jichao Li. All rights reserved.
//

#import "CHTUtil.h"


@implementation CHTUtil

+ (NSString *)getLocalizedString: (NSString *)str{
    return NSLocalizedString(str, NULL);
}

+ (NSString *)convertTimeFromMsecondToString: (int)msecond {
    NSString *outputTimeString;
    if (msecond < 1000) {
        outputTimeString = [NSString stringWithFormat:@"0.%03d", msecond];
    } else if (msecond < 60000) {
        int second = msecond * 0.001;
        int msec = msecond % 1000;
        outputTimeString = [NSString stringWithFormat:@"%d.%03d", second, msec];
    } else if (msecond < 3600000) {
        int minute = msecond / 60000;
        int second = (msecond % 60000)/1000;
        int msec = msecond % 1000;
        outputTimeString = [NSString stringWithFormat:@"%d:%02d.%03d", minute, second, msec];
    } else {
        int hour = msecond / 3600000;
        int minute = (msecond % 360000) / 60000;
        int second = (msecond % 60000) / 1000;
        int msec = msecond % 1000;
        outputTimeString = [NSString stringWithFormat:@"%d:%02d:%02d.%03d", hour, minute, second, msec];
    }
    return outputTimeString;
}



@end
