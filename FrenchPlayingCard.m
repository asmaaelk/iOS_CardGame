//
//  FrenchPlayingCard.m
//  M1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "FrenchPlayingCard.h"


@implementation FrenchPlayingCard
@synthesize suit = _suit;

+(NSArray *) rankStrings {
	return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
			 @"9", @"10", @"J", @"Q", @"K"];
}

+(NSArray *)validSuits {
	return @[@"♦️", @"♥️", @"♠️", @"♣️"];
}

+(NSUInteger) maxRank {
	return [[FrenchPlayingCard rankStrings] count] - 1;
}

-(NSString *) contents {
	NSArray *rankStrings = [FrenchPlayingCard rankStrings];
	return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

#define MATCH_RANK_SCORE 10
#define MATCH_SUIT_SCORE 4
#define MATCH_THREE_SUITS_SCORE 25
#define MATCH_THREE_RANKS_SCORE 100

- (int) scoreForMatchWith:(NSArray *)otherCards {
	int score = 0;
	if ([otherCards count] == 1) {
		FrenchPlayingCard * otherCard = otherCards[0];
		if (otherCard.rank == self.rank)
			score = MATCH_RANK_SCORE;
		else if (otherCard.suit == self.suit)
			score = MATCH_SUIT_SCORE;
	} else if ([otherCards count] == 2) {
		FrenchPlayingCard * otherCard0 = otherCards[0];
		FrenchPlayingCard * otherCard1 = otherCards[1];
		if ((otherCard0.suit == otherCard1.suit) &&
			(otherCard1.suit == self.suit)) {
			score = MATCH_THREE_SUITS_SCORE;
		} else if ((otherCard0.rank == otherCard1.rank) &&
				   (otherCard1.rank == self.rank)) {
			score = MATCH_THREE_RANKS_SCORE;
		}
	} else {
		NSLog(@"Error: scoreForMatchWith called with %d cards", [otherCards count]);
	}
	return score;
}

// The current project will still run fine if the next three
// methods - setSuit:, suit, setRank: - are deleted. TRY IT!
// That is because, at present, only FrenchPlayingCardDeck.m calls
// the setters and it makes sure to pass good values (and the
// default setters/getters will work fine with good values).
// This is "safer" code that might be useful when adding more
// functionality to the project.
//

- (void)setSuit:(NSString *)suit
{
    if ([[FrenchPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
	}
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [FrenchPlayingCard maxRank]) {
        _rank = rank;
	}
}

@end
