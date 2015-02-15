//
//  SettingsCell.h
//  EightBall
//
//  Created by Екатерина Колесникова on 13.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsCell;

@protocol SettingsCellDelegate < NSObject >
- (void)changeValueSoundSwitchInCell:(SettingsCell *)cell;
@end

@interface SettingsCell : UITableViewCell

@property (nonatomic, assign) id < SettingsCellDelegate > delegate;

@property (strong, nonatomic) IBOutlet UISwitch *soundSwitsh;
- (IBAction)changeValueSoundSwitch:(id)sender;

@end
