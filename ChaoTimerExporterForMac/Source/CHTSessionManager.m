//
//  CHTSessionManager.m
//  ChaoTimer
//
//  Created by Jichao Li on 10/2/13.
//  Copyright (c) 2013 Jichao Li. All rights reserved.
//

#import "CHTSessionManager.h"

#define KEY_SESSION_MANAGER @"sessionManager"
#define KEY_SESSION_ARRAY @"sessionArray"
#define KEY_STICKY_SESSION_ARRAY @"stickySessionArray"
#define KEY_CURRENT_SESSION_NAME @"currentSessionName"
#define KEY_SESSION @"CHTSession"
#define FILE_NAME @"CHTSessionManager"
#define FILE_SESSION_PREFIX @"CHTSession_"

@implementation CHTSessionManager




+ (CHTSession *) loadSessionWithName: (NSString *)fileName {

    CHTSession *session;
    NSData *data = [[NSData alloc] initWithContentsOfFile:fileName];
    if (data) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        @try {
            session = [unarchiver decodeObjectForKey:KEY_SESSION];
        }
        @catch (NSException * e) {
            session = [CHTSession initWithDefault];
            NSLog(@"Exception: %@", e);
        }
        @finally {
            [unarchiver finishDecoding];
        }
        NSLog(@"Load session: %@", session.sessionName);
        return session;
    }
    else {
        NSLog(@"Session does not exit");
        return session;
    }
}







@end
