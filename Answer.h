//
//  Answer.h
//  EightBall
//
//  Created by Екатерина Колесникова on 08.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    kEBNegativeSenseType = 0,
    kEBPositiveSenseType = 1,
    kEBNeutralSenseType = 2
} kEBSenseTypeid;

@interface Answer : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * sound;
@property (nonatomic, retain) NSNumber * sense;

+ (Answer *)randomAnswer;
- (void)removeAnswer;

@end

@interface NSFetchedResultsController (Answer)

+ (NSFetchedResultsController *)fetchedResultControllerAnswers;

@end