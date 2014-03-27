//
//  RecruitThingsTest.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import <XCTest/XCTest.h>
#import "Utils.h"
#import "Event.h"
#import "RecruitCharactersEventHandler.h"

@interface RecruitThingsTest : XCTestCase

@end

@implementation RecruitThingsTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    NSString *didRollMsg = @"{ \"data\":{ \"didRecruit\":false, \"specialCharacter\":{ \"id\":\"specialcharacter_04\", \"ownerId\":null, \"locationId\":\"side\", \"neutralized\":false }, \"playerId\":\"player4\", \"numPreRolls\":0, \"theRoll\":9, \"isMe\":true }, \"messageId\":\"gamemessage1395501091155r7wi0tk0pyoaglsh\", \"type\":\"didRollInRecruitCharactrs\", \"createdDate\":1395501091155 }";
    
    
    GameMessage *message = [Utils gameResponseMessageFromJSONData:[didRollMsg dataUsingEncoding:NSUTF8StringEncoding]];
    Event *e = [[Event alloc] initForType:@"" withMessage:message];
    
    RecruitCharactersEventHandler *handler = [[RecruitCharactersEventHandler alloc] init];
    [handler handleDidRollInRecruitCharactrs:e];
    
}

@end
