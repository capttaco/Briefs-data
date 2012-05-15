//
//  BFBriefcast.h
//  Briefs
//
//  Created by Rob Rhyne on 9/19/09.
//  Copyright Digital Arch Design, 2009. See LICENSE file for details.
//

#import <Foundation/Foundation.h>


@interface BFBriefcast : NSObject 
{
    NSString *url;
    NSString *title;
    NSString *description;
}

@property (nonatomic) NSString *url;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *description;

- (id)initWithName:(NSString *)name andURL:(NSString *)url;
- (id)initWithDictionary:(NSDictionary *)dict;

- (NSDictionary *)dictionary;

@end
