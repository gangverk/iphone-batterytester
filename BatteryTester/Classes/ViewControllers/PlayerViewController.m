//
//  PlayerViewController.m
//  BatteryTester
//
//  Created by Luis Flores on 10/11/13.
//  Copyright (c) 2013 Gangverk. All rights reserved.
//

#import "PlayerViewController.h"
#import "Config.h"
#import "Logger.h"

@interface PlayerViewController()
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property BOOL isTimerActive;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property float currentBatteryLevel;
@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    
    if ([Config sharedInstance].isConfigFileValid) {

        self.isTimerActive = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(batteryStateDidChange:)
                                                     name:UIDeviceBatteryLevelDidChangeNotification
                                                   object:nil];
        
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        
        UIDeviceBatteryState batteryState = [[UIDevice currentDevice] batteryState];
        
        self.currentBatteryLevel = [[UIDevice currentDevice] batteryLevel]*100;
        
        if (batteryState == UIDeviceBatteryStateUnknown) {
            self.batteryLabel.text = @"Battery status not available";
        }
        
        [self.player.avPlayerLayer setFrame:self.view.frame];
        [self.view.layer addSublayer:self.player.avPlayerLayer];
        [self.player playVideo];
        [Logger writeLogWithMessage:@"Video started"];
        
        self.batteryLabel.text = [NSString stringWithFormat:@"Battery: %.1f%%",self.currentBatteryLevel];
        
    } else {
        self.mainView.hidden = NO;
        self.batteryLabel.text = @"Battery status not available";

    }
}

- (Player *)player
{
    if (!_player) {
        _player = [[Player alloc] initWithVideoName:[Config sharedInstance].videoName];
    }
    
    return _player;
}

- (void)batteryStateDidChange:(NSNotification *)notification {

    self.currentBatteryLevel = [[UIDevice currentDevice] batteryLevel]*100;
    self.batteryLabel.text = [NSString stringWithFormat:@"Battery: %.1f%%", self.currentBatteryLevel];
    
    NSLog(@"Battery State Changed: %.1f%%", self.currentBatteryLevel);
    
    if ([[UIDevice currentDevice] batteryLevel] <= 0.11f) {
        [Logger writeLogWithMessage:[NSString stringWithFormat:@"Battery Level Changed: %.1f%%", self.currentBatteryLevel]];
        
        if (!self.isTimerActive) {
            
            self.isTimerActive = YES;
            [NSTimer scheduledTimerWithTimeInterval:60.0
                                             target:self
                                           selector:@selector(timer)
                                           userInfo:nil
                                            repeats:YES];
        }
    }
}

- (void)timer{
    [Logger writeLogWithMessage:[NSString stringWithFormat:@"Battery: %.1f%%", self.currentBatteryLevel]];
    self.currentBatteryLevel = [[UIDevice currentDevice] batteryLevel]*100;
}


@end
