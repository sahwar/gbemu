const std = @import("std");

const opcode = @import("opcode.zig");

pub const Disassembler = struct {
    input: *std.io.InStream,

    pub fn init(input: *std.io.FileInStream) Disassembler {
        return Disassembler{
            input: input,
        };
    }

    pub fn disassemble() []const u8 {
        switch (try self.input.readByte()) {
            NOP => "nop",
            LD_B_n => "ld b " ++ try self.input.readByte(),
            LD_C_n => "ld c " ++ try self.input.readByte(),
            LD_D_n => "ld d " ++ try self.input.readByte(),
            LD_E_n => "ld e " ++ try self.input.readByte(),
            LD_H_n => "ld h " ++ try self.input.readByte(),
            LD_L_n => "ld l " ++ try self.input.readByte(),
            LD_A_A => "ld a,a",
            LD_A_B => "ld a,b",
            LD_A_C => "ld a,c",
            LD_A_D => "ld a,d",
            LD_A_E => "ld a,e",
            LD_A_H => "ld a,h",
            LD_A_L => "ld a,l",
            LD_A_HL => "ld a,(hl)",
            LD_B_B => "ld b,b",
            LD_B_C => "ld b,c",
            LD_B_D => "ld b,d",
            LD_B_E => "ld b,e",
            LD_B_H => "ld b,h",
            LD_B_L => "ld b,l",
            LD_B_HL => "ld b,(hl)",
            LD_C_B => "ld c,b",
            LD_C_C => "ld c,c",
            LD_C_D => "ld c,d",
            LD_C_E => "ld c,e",
            LD_C_H => "ld c,h",
            LD_C_L => "ld c,l",
            LD_C_HL => "ld c,(hl)",
            LD_D_B => "ld d,b",
            LD_D_C => "ld d,c",
            LD_D_D => "ld d,d",
            LD_D_E => "ld d,e",
            LD_D_H => "ld d,h",
            LD_D_L => "ld d,l",
            LD_D_HL => "ld d,(hl)",
            LD_E_B => "ld e,b",
            LD_E_C => "ld e,c",
            LD_E_D => "ld e,d",
            LD_E_E => "ld e,e",
            LD_E_H => "ld e,h",
            LD_E_L => "ld e,l",
            LD_E_HL => "ld e,(hl)",
            LD_H_B => "ld h,b",
            LD_H_C => "ld h,c",
            LD_H_D => "ld h,d",
            LD_H_E => "ld h,e",
            LD_H_H => "ld h,h",
            LD_H_L => "ld h,l",
            LD_H_HL => "ld h,(hl)",
            LD_L_B => "ld l,b",
            LD_L_C => "ld l,c",
            LD_L_D => "ld l,d",
            LD_L_E => "ld l,e",
            LD_L_H => "ld l,h",
            LD_L_L => "ld l,l",
            LD_L_HL => "ld l,(hl)",
            LD_HL_B => "ld (hl),b",
            LD_HL_C => "ld (hl),c",
            LD_HL_D => "ld (hl),d",
            LD_HL_E => "ld (hl),e",
            LD_HL_H => "ld (hl),h",
            LD_HL_L => "ld (hl),l",
            LD_HL_HL => "ld (hl),(hl)",
            LD_HL_n => "ld (hl)," ++ try self.input.readByte(),
            LD_A_BC => "ld a,(bc)",
            LD_A_DE => "ld a,(de)",
            LD_A_nn => "ld a,(" ++ try self.input.readIntLe(u16) ++ ")",
            LD_A_n => "ld a," ++ try self.input.readByte(),
            LD_B_A => "ld b,a",
            LD_C_A => "ld c,a",
            LD_D_A => "ld d,a",
            LD_E_A => "ld e,a",
            LD_H_A => "ld h,a",
            LD_L_A => "ld l,a",
            LD_BC_A => "ld (bc),a",
            LD_DE_A => "ld (de),a",
            LD_HL_A => "ld (hl),a",
            LD_A_mem_C => "ld a,($FF00 + c)",
            LD_mem_C_A => "ld ($FF00 + c),a",
            LDD_A_HL => "ldd a,(hl)",
            LDD_HL_A => "ldd (hl),a",
        }
    }
};

test "Disassembler" {
}
