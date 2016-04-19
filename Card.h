//
//  Card.h
//  M1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString * contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) scoreForMatchWith:(NSArray *) otherCards;

@end
