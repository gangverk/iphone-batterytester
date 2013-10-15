//
//  Config.h
//  BatteryTester
//
//  Created by Luis Flores on 10/11/13.
//  Copyright (c) 2013 Gangverk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject {
    NSString *configFile;
    NSString *videoName;
    BOOL isConfigFileValid;

}

@property (nonatomic, retain) NSString *configFile;
@property (nonatomic, retain) NSString *videoName;
@property (nonatomic) BOOL isConfigFileValid;

+ (Config *)sharedInstance;
@end
