//
//  Answer.h
//  EightBall
//
//  Created by Екатерина Колесникова on 08.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "AddAnswerView.h"

@implementation AddAnswerView {
    UILabel *_titleLabel;
    UITextView *_answerTextField;
    UIButton *_saveButton;
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect viewFrame = self.frame;
    viewFrame.size.height =  viewFrame.size.height - 64.0f; //64 - высота NavigationBar`а

    self = [super initWithFrame:viewFrame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"Введите текст ответа";
        [self addSubview:_titleLabel];

        _answerTextField = [[UITextView alloc] initWithFrame:CGRectZero];
        _answerTextField.delegate = self;
        _answerTextField.editable = YES;
        _answerTextField.backgroundColor = [UIColor colorWithWhite:0.930 alpha:1.000];
        _answerTextField.textColor = [UIColor darkGrayColor];
        _answerTextField.font = [UIFont systemFontOfSize:16.0f];

        _answerTextField.layer.masksToBounds=YES;
        [[_answerTextField layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
        _answerTextField.layer.borderWidth= 1.3f;
        [_answerTextField setContentInset:UIEdgeInsetsMake(0.f, 7.f, 0.f, -7.f)];
        [self addSubview:_answerTextField];

        _saveButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_saveButton setBackgroundColor:[UIColor grayColor]];
        [_saveButton setTitle:@"Сохранить" forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [_saveButton addTarget:self action:@selector(performSaveAnswer:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_saveButton];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float viewWidth = self.frame.size.width;
    _titleLabel.frame = CGRectMake(10.f, 10.f, viewWidth - 20.f, 20.f);
    _answerTextField.frame = CGRectMake(10.f, 40.f, viewWidth - 20.f, 80.f);
    _saveButton.frame = CGRectMake(10.f, 130.f, viewWidth - 20.f, 40.f);
}

- (void)performSaveAnswer:(id)sender
{
    [self.delegate addAnswerView:self touchUpInsideSaveButton:sender saveAnswerText:_answerTextField.text];
}

#pragma mark - Property set

- (void)setDataSource:(id)dataSource
{
    _dataSource = dataSource;
    if (_dataSource) {
        _answerTextField.text = [_dataSource answerTextInAddAnswerView:self];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }

    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > 25) ? NO : YES;
}

@end
