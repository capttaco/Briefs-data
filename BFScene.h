//
//  BFScene.h
//  Briefs
//
//  Created by Rob Rhyne on 7/17/09.
//  Copyright Digital Arch Design, 2009. See LICENSE file for details.
//

#import <Foundation/Foundation.h>


@interface BFScene : NSObject 
{
    id          bg;
    NSArray     *actors;
    NSString    *name;
}

@property (nonatomic) id        bg;
@property (nonatomic) NSArray   *actors;
@property (nonatomic) NSString  *name;


- (id)init:(NSString *)name withDictionary:(NSDictionary *)dict;

- (NSDictionary *)copyAsDictionary;

@end
