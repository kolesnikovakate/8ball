//
//  SettingsViewController.h
//  EightBall
//
//  Created by Екатерина Колесникова on 06.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch *soundSwitsh;
- (IBAction)changeValueSoundSwitch:(id)sender;

@end
