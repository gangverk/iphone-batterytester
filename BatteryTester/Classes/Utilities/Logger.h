//
//  Logger.h
//  BatteryTester
//
//  Created by Luis Flores on 10/11/13.
//  Copyright (c) 2013 Gangverk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject  {
    NSFileManager *fileManager;
    NSString *logFileName;
}

@property (nonatomic, retain) NSString *logFileName;
@property (nonatomic, retain) NSFileManager *fileManager;


+ (Logger *)sharedInstance;
+ (void)writeLogWithMessage:(NSString *)message;
+ (void)cleanLogFile;
@end
