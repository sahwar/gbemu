const std = @import("std");

const opcode = @import("opcode.zig");

fn toLower(byte: u8) u8 {
    return switch (byte) {
        'A' ... 'Z' => byte - 'A',
        else => byte,
    };
}

const Token = struct {
    id: Id,
    start: usize,
    end: usize,

    const Keyword = struct {
        bytes: []const u8,
        id: Id,
    };

    const keywords = []const Keyword{
        Keyword{ .bytes = "adc", .id = Id.KeywordAdc },
        Keyword{ .bytes = "add", .id = Id.KeywordAdd },
        Keyword{ .bytes = "and", .id = Id.KeywordAnd },
        Keyword{ .bytes = "bit", .id = Id.KeywordBit },
        Keyword{ .bytes = "call", .id = Id.KeywordCall },
        Keyword{ .bytes = "ccf", .id = Id.KeywordCcf },
        Keyword{ .bytes = "cp", .id = Id.KeywordCp },
        Keyword{ .bytes = "cpl", .id = Id.KeywordCpl },
        Keyword{ .bytes = "daa", .id = Id.KeywordDaa },
        Keyword{ .bytes = "dec", .id = Id.KeywordDec },
        Keyword{ .bytes = "di", .id = Id.KeywordDi },
        Keyword{ .bytes = "db", .id = Id.KeywordDb },
        Keyword{ .bytes = "dw", .id = Id.KeywordDw },
        Keyword{ .bytes = "ei", .id = Id.KeywordEi },
        Keyword{ .bytes = "endc", .id = Id.KeywordEndC },
        Keyword{ .bytes = "endm", .id = Id.KeywordEndM },
        Keyword{ .bytes = "equs", .id = Id.KeywordEqus },
        Keyword{ .bytes = "halt", .id = Id.KeywordHalt },
        Keyword{ .bytes = "inc", .id = Id.KeywordInc },
        Keyword{ .bytes = "jp", .id = Id.KeywordJp },
        Keyword{ .bytes = "jr", .id = Id.KeywordJr },
        Keyword{ .bytes = "ld", .id = Id.KeywordLd },
        Keyword{ .bytes = "ldd", .id = Id.KeywordLdd },
        Keyword{ .bytes = "ldh", .id = Id.KeywordLdh },
        Keyword{ .bytes = "ldi", .id = Id.KeywordLdi },
        Keyword{ .bytes = "macro", .id = Id.KeywordMacro },
        Keyword{ .bytes = "nop", .id = Id.KeywordNop },
        Keyword{ .bytes = "or", .id = Id.KeywordOr },
        Keyword{ .bytes = "pop", .id = Id.KeywordPop },
        Keyword{ .bytes = "push", .id = Id.KeywordPush },
        Keyword{ .bytes = "rept", .id = Id.KeywordRept },
        Keyword{ .bytes = "res", .id = Id.KeywordRes },
        Keyword{ .bytes = "ret", .id = Id.KeywordRet },
        Keyword{ .bytes = "rl", .id = Id.KeywordRl },
        Keyword{ .bytes = "rla", .id = Id.KeywordRla },
        Keyword{ .bytes = "rlc", .id = Id.KeywordRlc },
        Keyword{ .bytes = "rlca", .id = Id.KeywordRlca },
        Keyword{ .bytes = "rr", .id = Id.KeywordRr },
        Keyword{ .bytes = "rra", .id = Id.KeywordRra },
        Keyword{ .bytes = "rrc", .id = Id.KeywordRrc },
        Keyword{ .bytes = "rrca", .id = Id.KeywordRrca },
        Keyword{ .bytes = "rst", .id = Id.KeywordRst },
        Keyword{ .bytes = "sbc", .id = Id.KeywordSbc },
        Keyword{ .bytes = "scf", .id = Id.KeywordScf },
        Keyword{ .bytes = "set", .id = Id.KeywordSet },
        Keyword{ .bytes = "sla", .id = Id.KeywordSla },
        Keyword{ .bytes = "sra", .id = Id.KeywordSra },
        Keyword{ .bytes = "srl", .id = Id.KeywordSrl },
        Keyword{ .bytes = "stop", .id = Id.KeywordStop },
        Keyword{ .bytes = "sub", .id = Id.KeywordSub },
        Keyword{ .bytes = "swap", .id = Id.KeywordSwap },
        Keyword{ .bytes = "xor", .id = Id.KeywordXor },
    };

    const Id = enum {
        Invalid,
        Eof,
        Identifier,
        HexLiteral,
        MacroParam,
        LeftParen,
        RightParen,
        LeftBracket,
        RightBracket,
        Comma,
        Colon,
        Newline,
        StringLiteral,
        KeywordAdc,
        KeywordAdd,
        KeywordAnd,
        KeywordBit,
        KeywordCall,
        KeywordCcf,
        KeywordCp,
        KeywordCpl,
        KeywordDaa,
        KeywordDec,
        KeywordDi,
        KeywordDb,
        KeywordDw,
        KeywordEi,
        KeywordEndC,
        KeywordEndM,
        KeywordEqus,
        KeywordHalt,
        KeywordInc,
        KeywordJp,
        KeywordJr,
        KeywordLd,
        KeywordLdd,
        KeywordLdh,
        KeywordLdi,
        KeywordMacro,
        KeywordNop,
        KeywordOr,
        KeywordPop,
        KeywordPush,
        KeywordRept,
        KeywordRes,
        KeywordRet,
        KeywordRl,
        KeywordRla,
        KeywordRlc,
        KeywordRlca,
        KeywordRr,
        KeywordRra,
        KeywordRrc,
        KeywordRrca,
        KeywordRst,
        KeywordSbc,
        KeywordScf,
        KeywordSet,
        KeywordSla,
        KeywordSra,
        KeywordSrl,
        KeywordStop,
        KeywordSub,
        KeywordSwap,
        KeywordXor,
    };
};

const Tokenizer = struct {
    const State = enum {
        Default,
        HexLiteral,
        StringLiteral,
        EscapeSequence,
        Identifier,
        Newline,
    };

    buffer: []const u8,
    index: usize,

    pub fn init(buffer: []const u8) Tokenizer {
        return Tokenizer{
            .buffer = buffer,
            .index = 0,
        };
    }

    pub fn next(self: *Tokenizer) Token {
        const start_index = self.index;
        var state = State.Default;
        var result = Token{
            .id = Token.Id.Eof,
            .start = self.index,
            .end = undefined,
        };
        while (self.index < self.buffer.len) : (self.index += 1) {
            const c = self.buffer[self.index];
            //std.debug.warn("state = {}, c = '{c}'\n", @tagName(state), c);
            switch (state) {
                State.Default => {
                    switch (c) {
                        '$' => {
                            result.id = Token.Id.HexLiteral;
                            state = State.HexLiteral;
                        },
                        '(' => {
                            result.id = Token.Id.LeftParen;
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        ')' => {
                            result.id = Token.Id.RightParen;
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        '[' => {
                            result.id = Token.Id.LeftBracket;
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        ']' => {
                            result.id = Token.Id.RightBracket;
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        ',' => {
                            result.id = Token.Id.Comma;
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        ':' => {
                            result.id = Token.Id.Colon;
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        ' ', '\t' => {
                            result.start = self.index + 1;
                        },
                        '"' => {
                            result.id = Token.Id.StringLiteral;
                            state = State.StringLiteral;
                        },
                        std.cstr.line_sep[0] => {
                            if (std.cstr.line_sep.len == 1) {
                                result.id = Token.Id.Newline;
                                result.end = self.index;
                                self.index += 1;
                                break;
                            }
                            state = State.Newline;
                        },
                        'a' ... 'z', 'A' ... 'Z', '_', '.' => {
                            result.id = Token.Id.Identifier;
                            state = State.Identifier;
                        },
                        else => {
                            result.id = Token.Id.Invalid;
                            result.end = self.index - 1;
                            break;
                        },
                    }
                },
                State.HexLiteral => {
                    switch (c) {
                        '0' ... '9', 'A' ... 'F', 'a' ... 'f'  => {},
                        else => {
                            result.end = self.index - 1;
                            break;
                        },
                    }
                },
                State.StringLiteral => {
                    switch (c) {
                        '"' => {
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        '\\' => {
                            state = State.EscapeSequence;
                        },
                        else => {},
                    }
                },
                State.EscapeSequence => {
                    switch (c) {
                        'i', 'p', 'f', 'b', 'I', 'o', 'a', 't', 'P', 'C', '\\', '\'', '"', '0' => {
                            state = State.StringLiteral;
                        },
                        else => {
                            result.id = Token.Id.Invalid;
                            break;
                        },
                    }
                },
                State.Identifier => {
                    switch (c) {
                        'A' ... 'Z', 'a' ... 'z', '0' ... '9', '_' => {},
                        else => {
                            result.end = self.index - 1;
                            const str = self.buffer[result.start..self.index];
                            var lower: [256]u8 = undefined;
                            for (str) |byte, i| {
                                lower[i] = toLower(byte);
                            }
                            if (findKeyword(lower[0..str.len])) |keyword| {
                                result.id = keyword.id;
                            }
                            break;
                        },
                    }
                },
                State.Newline => {
                    std.debug.assert(std.cstr.line_sep.len == 2);
                    switch (c) {
                        std.cstr.line_sep[std.cstr.line_sep.len-1] => {
                            result.end = self.index;
                            self.index += 1;
                            break;
                        },
                        else => {
                            result.id = Token.Id.Invalid;
                            break;
                        },
                    }
                },
            }
        }
        if (self.index == self.buffer.len) {
            switch (state) {
                State.EscapeSequence => {
                    result.id = Token.Id.Invalid;
                },
                else => {},
            }
        }
        return result;
    }

    fn findKeyword(str: []const u8) ?Token.Keyword {
        var first: usize = 0;
        var last: usize = Token.keywords.len;
        var pos: usize = undefined;
        var count: usize = Token.keywords.len;
        var step: usize = undefined;
        while (count > 0) {
            pos = first;
            step = count / 2;
            pos += step;
            if (std.mem.lessThan(u8, Token.keywords[pos].bytes, str)) {
                pos += 1;
                first = pos;
                count -= step + 1;
            } else {
                count = step;
            }
        }
        if (std.mem.eql(u8, Token.keywords[first].bytes, str)) {
            return Token.keywords[first];
        }
        return null;
    }
};

pub const Assembler = struct {
    tokenizer: Tokenizer,

    pub fn init(buffer: []const u8) Assembler {
        return Assembler{
            .tokenizer = Tokenizer.init(buffer),
        };
    }

    pub fn assemble(self: *Assembler) opcode.Opcode {
        // TODO
        var i: usize = 0;
        while (i < 100) : (i += 1) {
            const token = self.tokenizer.next();
            if (token.id == Token.Id.Invalid) {
                std.debug.warn("Invalid token\n");
                break;
            }
            if (token.id == Token.Id.Eof) {
                std.debug.warn("EOF\n");
                break;
            }
            std.debug.warn("{} '{}'\n", @tagName(token.id), self.tokenizer.buffer[token.start..token.end+1]);
        }
        return opcode.Opcode.NOP;
    }
};

test "Assembler" {
    const contents = try std.io.readFileAlloc(std.debug.global_allocator, "testdata/test.s");
    defer std.debug.global_allocator.free(contents);
    var assembler = Assembler.init(contents);
    const op = assembler.assemble();
}
