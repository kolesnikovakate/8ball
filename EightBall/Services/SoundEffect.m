//
//  SoundEffect.m
//  EightBall
//
//  Created by Екатерина Колесникова on 10.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "SoundEffect.h"

@implementation SoundEffect

- (id)init8BallSound
{
    return [self initWithSoundNamed:@"soundeffect.m4a"];
}

- (id)initWithSoundNamed:(NSString *)filename
{
    if ((self = [super init]))
    {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID resourceSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &resourceSoundID);
            if (error == kAudioServicesNoError)
                soundID = resourceSoundID;
        }
    }
    return self;
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}

- (void)play
{
    AudioServicesPlaySystemSound(soundID);
}

@end