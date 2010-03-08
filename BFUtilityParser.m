//
//  BFUtilityParser.m
//  Briefs
//
//  Created by Rob Rhyne on 8/22/09.
//  Copyright Digital Arch Design, 2009. See LICENSE file for details.
//


#import "BFUtilityParser.h"
#import "BFConstants.h"


@implementation BFUtilityParser


///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Action Parse Methods

+ (NSString *)parseActionCommand:(NSString *)action
{
    NSString *lowered = [action lowercaseString];
    
    if ([lowered hasPrefix:kBFActorActionGoto]) {
        return kBFActorActionGoto;
        
    } else if ([lowered hasPrefix:kBFActorActionToggle]) {
        return kBFActorActionToggle;
        
    } else if ([lowered hasPrefix:kBFActorActionResize]) {
        return kBFActorActionResize;
        
    } else if ([lowered hasPrefix:kBFActorActionMove]) {
        return kBFActorActionMove;
    
    } else if ([lowered hasPrefix:kBFActorActionHide]) {
        return kBFActorActionHide;
    
    } else if ([lowered hasPrefix:kBFActorActionShow]) {
        return kBFActorActionShow;
    }
    
    // TODO: throw exception?
    return nil;
}


+ (NSArray *)parseActionArgsIntoArray:(NSString *)action withPrefix:(NSString *)prefix
{
	// check for the a nil action
	if (action != nil && ![action isEqual:@""]) {
		
		// normalize the action string
		NSString *lowered = [[action lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; 
		
		NSRange start = [lowered rangeOfString:@"("];
		NSRange end = [lowered rangeOfString:@")"];
		
		NSString *argumentsAsString = [[lowered substringToIndex:end.location] substringFromIndex:start.location+1];
		NSArray *argumentsAsArray = [argumentsAsString componentsSeparatedByString:@","];
		
		return argumentsAsArray;
	}
	
	else return nil;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Scene Transition Parse Methods

+ (NSString *)parseSceneTransitionCommand:(NSString *)transition
{
    // TODO: Do something here.
    return nil;
}

+ (NSArray  *)parseSceneTransitionOptionsIntoArray:(NSString *)transition withPrefix:(NSString *)prefix
{
    // TODO: Do something here.
    return nil;
}

///////////////////////////////////////////////////////////////////////////////



@end
