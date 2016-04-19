//
//  MatchingGame.m
//  CardGame1
//
//  Created by James Cremer on 2/6/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "MatchingGame.h"

@interface MatchingGame ()
@property (strong, nonatomic) NSMutableArray *cardsInPlay;
@property (strong, nonatomic) NSMutableArray *chosenCards;
@property (nonatomic, readwrite) NSInteger score;
@end

@implementation MatchingGame

-(NSMutableArray *) cardsInPlay {
	if (!_cardsInPlay)
		_cardsInPlay = [[NSMutableArray alloc] init];
	return _cardsInPlay;
}

-(NSMutableArray *) chosenCards {
	if (!_chosenCards)
		_chosenCards = [[NSMutableArray alloc] init];
	return _chosenCards;
}

-(instancetype) initWithNumCards:(NSUInteger)numCards fromDeck:(Deck *)deck {
	self = [super init];
	for (int i = 0; i < numCards; i++) {
		Card *card = [deck drawRandomCard];
		if (card)
			[self.cardsInPlay addObject:card];
		else {
			self = nil;
			break;
		}
	}
	return self;
};

-(instancetype) initWithNumCards:(NSUInteger)numCards
						fromDeck:(Deck *)deck
					 andMatchType:(int) numToMatch {
	self = [self initWithNumCards:numCards fromDeck:deck];
	if (self)
		self.gameType = numToMatch;
	else
		self = nil;
	return self;
};

#define COST_TO_CHOOSE 1
#define COST_FOR_MISMATCH 1

-(void) chooseCardAtIndex: (NSUInteger)index {
	Card *chosenCard = [self.cardsInPlay objectAtIndex:index];
	if (!chosenCard.isMatched) {
		if (chosenCard.isChosen) {
			chosenCard.chosen = NO;
			[self.chosenCards removeObject:chosenCard];
		} else {
			if (self.gameType == 2)
				[self chooseTwoGameCard:chosenCard];
			else
				[self chooseThreeGameCard:chosenCard];
		}
	}
}

-(void) chooseTwoGameCard:(Card *)chosenCard {
	for (Card *otherCard in self.cardsInPlay) {
		if (otherCard.isChosen && !otherCard.isMatched) {
			int matchScore = [chosenCard scoreForMatchWith:@[otherCard]];
			if (matchScore) {
				self.score = self.score + matchScore;
				chosenCard.matched = YES;
				otherCard.matched = YES;
			} else {
				self.score = self.score - COST_FOR_MISMATCH;
				otherCard.chosen = NO;
				[self.chosenCards removeObject:otherCard];
			}
			break;
		}
	}
	chosenCard.chosen = YES;
	[self.chosenCards addObject:chosenCard];
	self.score = self.score - COST_TO_CHOOSE;
}

-(void) chooseThreeGameCard:(Card *)chosenCard {
	if ([self.chosenCards count] < 3) {
		chosenCard.chosen = YES;
		self.score = self.score - COST_TO_CHOOSE;
		if ([self.chosenCards count] == 2) {
			int matchScore = [chosenCard scoreForMatchWith:self.chosenCards];
			if (matchScore) {
				self.score = self.score + matchScore;
				chosenCard.matched = YES;
				Card *chosenCard0 = self.chosenCards[0];
				Card *chosenCard1 = self.chosenCards[1];
				chosenCard0.matched = YES;
				chosenCard1.matched = YES;
				[self.chosenCards removeObject:chosenCard0];
				[self.chosenCards removeObject:chosenCard1];
			} else {
				self.score = self.score - COST_FOR_MISMATCH;
				[self.chosenCards addObject:chosenCard];
			}
		} else {
			[self.chosenCards addObject:chosenCard];
		}
	}
}

-(Card *) cardAtIndex: (NSUInteger)index {
	return [self.cardsInPlay objectAtIndex:index];
}

@end
