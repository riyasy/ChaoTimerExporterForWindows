//
//  main.m
//  ChaoFileExporter
//
//  Created by Riyas on 25/01/22.
//

#import <Foundation/Foundation.h>
#import "CHTSession.h"
#import "CHTSessionManager.h"

// convert penalty type enum to string
NSString * const FormatType_toString[] = {
    [PENALTY_NO_PENALTY] = @"PENALTY_NO_PENALTY",
    [PENALTY_PLUS_2] = @"PENALTY_PLUS_2",
    [PENALTY_DNF] = @"PENALTY_DNF"
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Find all binary plist files in the given directory
        // The directory should contain only binary plist files corresponding to sessions
        NSString *sourcePath = @"/Users/tarmac/Desktop/KK";
        NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                            error:NULL];
        NSMutableArray *pListFiles = [[NSMutableArray alloc] init];
        [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *filename = (NSString *)obj;
            NSString *extension = [[filename pathExtension] lowercaseString];
            if ([extension isEqualToString:@"plist"]) {
                [pListFiles addObject:[sourcePath stringByAppendingPathComponent:filename]];
            }
        }];
        
        // Create output csv content header
        NSMutableString *csvContent = [[NSMutableString alloc]init];
        [csvContent appendString:@"TimeOfSolve,TimeBeforePenalty,TimeAfterPenalty,Scramble,ScrambleType,ScrambleSubType,PenaltyType\n"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        for (NSString* pListFile in pListFiles)
        {
            // Deserialize the session plist using original Data classes from ChaoTimer
            CHTSession *session = [CHTSessionManager loadSessionWithName:pListFile];
            
            for (CHTSolve* solve in [session getAllSolves])
            {
                // Add contents of interest to csv
                NSString *str = [NSString stringWithFormat: @"%@,%i,%i,%@,%@,%@,%@\n",
                                 [dateFormatter stringFromDate:solve.timeStamp],
                                 solve.timeBeforePenalty,
                                 [solve timeAfterPenalty],
                                 solve.scramble.scramble,
                                 solve.scramble.scrType,
                                 solve.scramble.scrSubType,
                                 FormatType_toString[solve.penalty]
                                 ];
                [csvContent appendString:str];
            }
        }
        
        // Create output file path
        NSDate *currentDate = [NSDate date];
        [dateFormatter setDateFormat:@"yyyyMMdd-HHmmss"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        NSString *outPutFilePath = [NSString stringWithFormat: @"%@_%@.txt",
                                    @"ChaoExportFile",
                                    dateString];
        //get the documents directory:
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [documentsDirectory stringByAppendingPathComponent: outPutFilePath];
        //save content to the documents directory
        [csvContent writeToFile:fileName
                     atomically:NO
                       encoding:NSStringEncodingConversionAllowLossy
                          error:NULL];
        
        
        NSLog(@"Finished!");
    }
    return 0;
}

