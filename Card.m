//
//  Card.m
//  M1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "Card.h"

@implementation Card

// We do not expect to use this method.  Specialized
// card classes should provide their own scoreForMatchWith
//
- (int) scoreForMatchWith:(NSArray *)otherCards {
	return 0;
}

@end
