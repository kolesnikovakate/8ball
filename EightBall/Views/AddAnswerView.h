//
//  Answer.h
//  EightBall
//
//  Created by Екатерина Колесникова on 08.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddAnswerView;

@protocol AddAnswerViewDelegate < NSObject >
- (void)addAnswerView:(AddAnswerView *)view touchUpInsideSaveButton:(UIButton *)saveButton saveAnswerText:(NSString *)answerText;
@end

@protocol AddAnswerViewDataSource < NSObject >
- (NSString *)answerTextInAddAnswerView:(AddAnswerView *)addAnswerView;
@end

@interface AddAnswerView : UIView < UITextViewDelegate >

@property (nonatomic, assign) id < AddAnswerViewDelegate > delegate;
@property (nonatomic, assign) id < AddAnswerViewDataSource > dataSource;

@end
