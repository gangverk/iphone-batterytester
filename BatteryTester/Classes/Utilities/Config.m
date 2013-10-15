//
//  Config.m
//  BatteryTester
//
//  Created by Luis Flores on 10/11/13.
//  Copyright (c) 2013 Gangverk. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize configFile;
@synthesize isConfigFileValid;
@synthesize videoName;

#pragma mark - Singleton

+ (Config *)sharedInstance
{
    static dispatch_once_t pred;
    static Config *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        configFile = @"config.txt";
    }
    return self;
}
@end
