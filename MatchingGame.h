//
//  MatchingGame.h
//  CardGame1
//
//  Created by James Cremer on 2/6/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface MatchingGame : NSObject

// Designated initializer for Matching Game - all other initializers should call this
//
-(instancetype) initWithNumCards:(NSUInteger)numCards fromDeck:(Deck *)deck;

-(instancetype) initWithNumCards:(NSUInteger)numCards
						fromDeck:(Deck *)deck
					 andMatchType:(int) numToMatch;

// A "command" from view controller telling model/game that player
// has chosen a card.  Model/game should update state based on that
// choice.  Then it is up to the view controller to query relevant
// aspects of the game state and reflect that in the UI.
//
-(void) chooseCardAtIndex: (NSUInteger)index;


// Retrieve card/card info, whether chosen or not
// This and score property (below) will be used by view controller to
// query game state and reflect it in UI.
//
-(Card *) cardAtIndex: (NSUInteger)index;

@property (nonatomic) NSInteger gameType;
@property (nonatomic, readonly) NSInteger score;

@end
