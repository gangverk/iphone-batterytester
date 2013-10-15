//
//  AppDelegate.m
//  BatteryTester
//
//  Created by Luis Flores on 10/11/13.
//  Copyright (c) 2013 Gangverk. All rights reserved.
//

#import "AppDelegate.h"
#import "PlayerViewController.h"
#import "Logger.h"
#import "Config.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setLogFile];
    [self setConfigFile];
    return YES;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [Logger writeLogWithMessage:@"Application inactive state"];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [Logger writeLogWithMessage:@"Application terminate"];

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setLogFile
{
    //Log file
    NSString *fileName = @"log.txt";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the get the path to the Documents directory
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Combine Documents directory path with your file name to get the full path
    NSString *documentDBFolderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //check if file does exists on specific path, if it doesn't do something
    if (![fileManager fileExistsAtPath:documentDBFolderPath])
    {
        //Get path to the file that has been created on the first step and included to the App resources
        NSString *resourceDBFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        
        //Copy resources file to destination folder
        [fileManager copyItemAtPath:resourceDBFolderPath toPath:documentDBFolderPath error:&error];
    }
    
    [Logger cleanLogFile];
}

- (void)setConfigFile
{
    
    NSString *configName = [Config sharedInstance].configFile;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentDBFolderPath = [documentsDirectory stringByAppendingPathComponent:configName];
    
    if (![fileManager fileExistsAtPath: documentDBFolderPath]) {
        NSString *resourceDBFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:configName];
        [fileManager copyItemAtPath:resourceDBFolderPath toPath:documentDBFolderPath  error:&error];
    }
    
    NSString *fileContents = [NSString stringWithContentsOfFile:documentDBFolderPath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        [Config sharedInstance].isConfigFileValid = NO;
        [Logger writeLogWithMessage:@"Invalid Config File"];
        NSLog(@"Invalid Config File");
    } else {
        [Config sharedInstance].isConfigFileValid = YES;
        NSArray *listArray = [fileContents  componentsSeparatedByString:@"\n"];
        NSString *newMovie = [listArray  objectAtIndex:0];
        
        if (![newMovie length]) {
            [Config sharedInstance].isConfigFileValid = NO;
        } else {
            [Config sharedInstance].videoName = newMovie;
        }
    }
}


@end
