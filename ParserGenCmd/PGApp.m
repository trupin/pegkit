#import "PGApp.h"
#import "PGParserFactory.h"
#import "PGRootNode.h"
#import "PGParserGenVisitor.h"

@interface PGApp ()

@property(nonatomic, strong) PGParserFactory *factory;

@end

@implementation PGApp

- (instancetype)init {
    self = [super init];

    if (self) {
        self.factory = [PGParserFactory factory];
        _factory.collectTokenKinds = YES;
    }

    return self;
}

- (int)generateWithInputPath:(NSString *)inputPath outPutDirPath:(NSString *)outPutDirPath outPutParserName:(NSString *)parserName {
    NSError *error = nil;

    NSString *grammar = [NSString stringWithContentsOfFile:inputPath encoding:NSUTF8StringEncoding error:&error];
    if (error) return [self done:error];

    PGRootNode *root = (id)[_factory ASTFromGrammar:grammar error:&error];
    if (error) return [self done:error];

    NSAssert([root.startMethodName length], @"");
    NSAssert([parserName length], @"");

    root.grammarName = parserName;

    PGParserGenVisitor *visitor = [[PGParserGenVisitor alloc] init];
    visitor.enableARC = YES;
    visitor.enableMemoization = YES;
    @try {
        [root visit:visitor];
    }
    @catch (NSException *ex) {
        id userInfo = @{NSLocalizedFailureReasonErrorKey: [ex reason]};
        NSError *err = [NSError errorWithDomain:[ex name] code:0 userInfo:userInfo];
        return [self done:err];
    }

    NSString *path = [[NSString stringWithFormat:@"%@/%@.h", outPutDirPath, parserName] stringByExpandingTildeInPath];
    if (![visitor.interfaceOutputString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        NSMutableString *str = [NSMutableString stringWithString:[error localizedFailureReason]];
        [str appendFormat:@"\n\n%@", [path stringByDeletingLastPathComponent]];
        id dict = [NSMutableDictionary dictionaryWithDictionary:[error userInfo]];
        dict[NSLocalizedFailureReasonErrorKey] = str;
        return [self done:[NSError errorWithDomain:[error domain] code:[error code] userInfo:dict] ];
    }

    path = [[NSString stringWithFormat:@"%@/%@.m", outPutDirPath, parserName] stringByExpandingTildeInPath];
    if (![visitor.implementationOutputString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        NSMutableString *str = [NSMutableString stringWithString:[error localizedFailureReason]];
        [str appendFormat:@"\n\n%@", [path stringByDeletingLastPathComponent]];
        id dict = [NSMutableDictionary dictionaryWithDictionary:[error userInfo]];
        dict[NSLocalizedFailureReasonErrorKey] = str;
        return [self done:[NSError errorWithDomain:[error domain] code:[error code] userInfo:dict]];
    }

    [visitor release];
    return 0;
}

- (int)done:(NSError *)error {
    if (error) {
        fprintf(stderr, "%s", [error.description cStringUsingEncoding:NSUTF8StringEncoding]);
        return 1;
    }

    return 0;
}

@end