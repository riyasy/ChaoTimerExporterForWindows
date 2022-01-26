//
//  CHTSessionManager.h
//  ChaoTimer
//
//  Created by Jichao Li on 10/2/13.
//  Copyright (c) 2013 Jichao Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHTSession.h"


@interface CHTSessionManager : NSObject <NSCoding>


+ (CHTSession *) loadSessionWithName: (NSString *)name;


@end
