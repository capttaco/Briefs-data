//
//  BFActor.m
//  Briefs
//
//  Created by Rob Rhyne on 7/17/09.
//  Copyright Digital Arch Design, 2009. See LICENSE file for details.
//

#import "BFActor.h"
#import "BFDispatch.h"
#import "BFConstants.h"


@implementation BFActor
@synthesize bg, name, size, action, touchedBg, disabledBg, releasedBg, isActive, visible, scrollable;



///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Action Support

+ (NSArray *)copyOfAvailableActions {
    // FIXME Best way to represent this?
    return [[NSArray alloc] initWithObjects:kBFActorActionGoto, kBFActorActionToggle,
                    kBFActorActionResize, kBFActorActionMove, nil];
}


///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject overrides

- (id)init:(NSString*)name withDictionary:(NSDictionary*)dict
{
    isActive = true; 
    
    // TODO: Refactor this into a Briefs data formatter
    if (self = [super init]) {
        self.name = [dict valueForKey:@"name"];

        // backgrounds
        self.bg = [dict valueForKey:@"img"];
        
        self.touchedBg = [dict valueForKey:@"touched"];
        self.disabledBg = [dict valueForKey:@"disabled"];
        self.releasedBg = [dict valueForKey:@"released"];
        
        self.visible = [dict valueForKey:@"visible"] != nil ? [[dict valueForKey:@"visible"] boolValue] : YES;
		self.scrollable = [dict valueForKey:@"scrollable"] != nil ? [[dict valueForKey:@"visible"] boolValue] : NO;
        
        // Dimensions
        NSNumber *x = [dict valueForKey:@"x"];
        NSNumber *y = [dict valueForKey:@"y"];
        NSNumber *width = [dict valueForKey:@"width"];
        NSNumber *height = [dict valueForKey:@"height"];
        self.size = CGRectMake([x floatValue], [y floatValue], [width floatValue], [height floatValue]);
        
        // Action
        // TODO: generalize this as well?
        self.action = [dict valueForKey:@"action"]; 
    }
    return self;
}

- (void)dealloc 
{
    [bg release];
    [name release];
    [action release];
    [touchedBg release];
    [disabledBg release];
    [releasedBg release];
    [super dealloc];
}

- (NSDictionary *)copyAsDictionary
{
    NSMutableArray *keys = [NSMutableArray arrayWithArray:
    [NSArray arrayWithObjects:@"img", @"x", @"y", @"width", @"height", @"name", @"action", @"visible", nil]];
    
    // Required values
    NSNumber *x = [NSNumber numberWithDouble:[self size].origin.x];
    NSNumber *y = [NSNumber numberWithDouble:[self size].origin.y];
    NSNumber *width = [NSNumber numberWithDouble:[self size].size.width];
    NSNumber *height = [NSNumber numberWithDouble:[self size].size.height];
    NSString *background = [self bg] == nil ? @"" : [self bg];
    NSNumber *isVisible = [NSNumber numberWithBool:[self visible]];
    NSMutableArray *values = [NSMutableArray arrayWithArray:
                              [NSArray arrayWithObjects:background, x, y, width, height, [self name], [self action], isVisible, nil]];
   
    
    // check for alternate backgrounds
    // ===============================
    // disabled, touched, released, etc
    
    if (self.disabledBg != nil) {
        [keys addObject:@"disabled"];
        [values addObject:[self disabledBg]];
    }
    
    if (self.touchedBg != nil) {
        [keys addObject:@"touched"];
        [values addObject:[self touchedBg]];
    }
    
    if (self.releasedBg != nil) {
        [keys addObject:@"released"];
        [values addObject:[self releasedBg]];
    }
	
	if (self.scrollable) {
		NSNumber *isScrollable = [NSNumber numberWithBool:[self scrollable]];
		[keys addObject:@"scrollable"];
		[values addObject:isScrollable];
	}
  

    NSDictionary *dict = [[NSDictionary dictionaryWithObjects:values forKeys:keys] retain];
    return dict;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark State Management

- (void)activate
{
    isActive = true;
}

- (void)deactivate 
{
    isActive = false;
}

- (void)toggle
{
    if (isActive) {
        [self deactivate];
    }
    else [self activate];
}

- (NSString *)background
{
    // Check for empty string, produces
    // erratic behavior if empty.
    if ([self.bg isEqual:@""]) return nil;
    
    if (isActive)
        return [self bg];
    else
        return [self disabledBg];
}

///////////////////////////////////////////////////////////////////////////////

@end
