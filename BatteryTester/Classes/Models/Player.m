//
//  Player.m
//  BatteryTester
//
//  Created by Luis Flores on 10/14/13.
//  Copyright (c) 2013 Gangverk All rights reserved.
//

#import "Player.h"


@interface Player()
@property (strong, nonatomic) AVPlayerItem *avPlayerItem;
@property (strong, nonatomic) AVAsset *avAsset;
@property (strong, nonatomic) AVPlayer *avPlayer;

@end

@implementation Player

- (id)initWithVideoName:(NSString *)videoName
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory
                              stringByAppendingPathComponent:videoName];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        self.avAsset = [AVAsset assetWithURL:fileUrl];
        self.avPlayerItem =[[AVPlayerItem alloc]initWithAsset:self.avAsset];
        self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.avPlayerItem];
        self.avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        
        [self.avPlayer seekToTime:kCMTimeZero];
        
        self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[self.avPlayer currentItem]];
    }
    return self;
}

- (void)playVideo
{
    [self.avPlayer play];
}

//Play again the video
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

@end
