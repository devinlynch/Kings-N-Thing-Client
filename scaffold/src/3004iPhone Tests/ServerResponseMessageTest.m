//
//  ServerResponseMessageTest.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <XCTest/XCTest.h>
#import "ServerResponseMessage.h"
@interface ServerResponseMessageTest : XCTestCase

@end

@implementation ServerResponseMessageTest

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

- (void)testJSON1
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"test" forKey:@"type"];
    [dic setObject:@"devin" forKey:@"name"];
    [dic setObject:@"1" forKey:@"responseStatus"];
    ServerResponseMessage *message = [[ServerResponseMessage alloc] initFromJSON:dic];
    
    XCTAssertEqual(@"test", message.type);
    XCTAssertEqual(@"devin", message.name);
    XCTAssertEqual(1, message.responseStatus);
}

- (void)testJSON2
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    ServerResponseMessage *message = [[ServerResponseMessage alloc] initFromJSON:dic];
    
    XCTAssertNil(message.type);
    XCTAssertNil(message.name);
}

- (void)testJSON3
{
    NSMutableDictionary *edic = [[NSMutableDictionary alloc] init];
    [edic setObject:@"1" forKey:@"responseError"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:edic forKey:@"error"];
    ServerResponseMessage *message = [[ServerResponseMessage alloc] initFromJSON:dic];
    
    XCTAssertEqual(1, message.error.responseError);
}

- (void)testJSON4
{
    NSMutableDictionary *ddic = [[NSMutableDictionary alloc] init];
    [ddic setObject:@"1" forKey:@"map"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:ddic forKey:@"data"];
    ServerResponseMessage *message = [[ServerResponseMessage alloc] initFromJSON:dic];
    
    XCTAssertNil(message.data.map);
}

- (void)testJSON5
{
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    [map setObject:@"devin" forKey:@"name"];
    
    NSMutableDictionary *ddic = [[NSMutableDictionary alloc] init];
    [ddic setObject:map forKey:@"map"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:ddic forKey:@"data"];
    ServerResponseMessage *message = [[ServerResponseMessage alloc] initFromJSON:dic];
    
    XCTAssertEqual(@"devin", [message.data.map objectForKey:@"name"]);
}

@end
