//
//  Logger.m
//  BatteryTester
//
//  Created by Luis Flores on 10/11/13.
//  Copyright (c) 2013 Gangverk. All rights reserved.
//

#import "Logger.h"

@implementation Logger

@synthesize logFileName;
@synthesize fileManager;

#pragma mark - Singleton

+ (Logger *)sharedInstance
{
    static dispatch_once_t pred;
    static Logger *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //file name to write the data to using the documents directory:
        logFileName = [NSString stringWithFormat:@"%@/log.txt", documentsDirectory];
        fileManager = [NSFileManager defaultManager];
        
        
    }
    return self;
}

+ (void)writeLogWithMessage:(NSString *)message
{
   if (![[Logger sharedInstance].fileManager fileExistsAtPath:[Logger sharedInstance].logFileName]) {
        
        // the file doesn't exist
        NSLog(@"Error");
        
    } else {
        // get a handle
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[Logger sharedInstance].logFileName];
        
        // move to the end of the file
        [fileHandle seekToEndOfFile];
        
        NSDate *currentDate = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *formattedDateString = [dateFormatter stringFromDate:currentDate];
        
        NSString *logMessage = [NSString stringWithFormat:@"%@ - %@\n", formattedDateString, message];
        
        // convert the string to an NSData object
        NSData *textData = [logMessage dataUsingEncoding:NSUTF8StringEncoding];
        
        // write the data to the end of the file
        [fileHandle writeData: textData];
        
        // clean up
        [fileHandle closeFile];
    }
}

+ (void)cleanLogFile
{
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[Logger sharedInstance].logFileName];
        
    if (fileHandle == nil) {
        NSLog(@"Failed to open file");
    }
    
    [fileHandle truncateFileAtOffset: 0];
    
    [fileHandle closeFile];
}
@end
