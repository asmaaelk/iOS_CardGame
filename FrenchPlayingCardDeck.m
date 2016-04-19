//
//  PlayingCardDeck.m
//  M1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "FrenchPlayingCardDeck.h"
#import "FrenchPlayingCard.h"

@implementation FrenchPlayingCardDeck

- (instancetype)init
{
    self = [super init];
	if (self) {
        for (NSString *suit in [FrenchPlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [FrenchPlayingCard maxRank]; rank++) {
				FrenchPlayingCard *card = [[FrenchPlayingCard alloc] init];
				card.rank = rank;
				card.suit = suit;
				[self addCard:card];
			}
		}
	}
	return self;
}
@end
