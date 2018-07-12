const std = @import("std");

const opcode = @import("opcode.zig");

pub const Disassembler = struct {
    const InStream = std.io.InStream(std.os.File.ReadError);
    const OutStream = std.io.OutStream(std.os.File.WriteError);

    input: *InStream,
    output: *OutStream,
    buffer: ?u8,

    pub fn init(input: *InStream, output: *OutStream) Disassembler {
        return Disassembler{
            .input = input,
            .output = output,
            .buffer = null,
        };
    }

    pub fn disassemble(self: *Disassembler) !void {
        const byte = self.buffer orelse try self.input.readByte();
        switch (byte) {
            @enumToInt(opcode.Opcode.NOP) => try self.output.print("nop"),
            @enumToInt(opcode.Opcode.LD_A_n) => try self.output.print("ld a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_B_n) => try self.output.print("ld b,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_C_n) => try self.output.print("ld c,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_D_n) => try self.output.print("ld d,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_E_n) => try self.output.print("ld e,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_H_n) => try self.output.print("ld h,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_L_n) => try self.output.print("ld l,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_A_A) => try self.output.print("ld a,a"),
            @enumToInt(opcode.Opcode.LD_A_B) => try self.output.print("ld a,b"),
            @enumToInt(opcode.Opcode.LD_A_C) => try self.output.print("ld a,c"),
            @enumToInt(opcode.Opcode.LD_A_D) => try self.output.print("ld a,d"),
            @enumToInt(opcode.Opcode.LD_A_E) => try self.output.print("ld a,e"),
            @enumToInt(opcode.Opcode.LD_A_H) => try self.output.print("ld a,h"),
            @enumToInt(opcode.Opcode.LD_A_L) => try self.output.print("ld a,l"),
            @enumToInt(opcode.Opcode.LD_A_HL) => try self.output.print("ld a,(hl)"),
            @enumToInt(opcode.Opcode.LD_B_B) => try self.output.print("ld b,b"),
            @enumToInt(opcode.Opcode.LD_B_C) => try self.output.print("ld b,c"),
            @enumToInt(opcode.Opcode.LD_B_D) => try self.output.print("ld b,d"),
            @enumToInt(opcode.Opcode.LD_B_E) => try self.output.print("ld b,e"),
            @enumToInt(opcode.Opcode.LD_B_H) => try self.output.print("ld b,h"),
            @enumToInt(opcode.Opcode.LD_B_L) => try self.output.print("ld b,l"),
            @enumToInt(opcode.Opcode.LD_B_HL) => try self.output.print("ld b,(hl)"),
            @enumToInt(opcode.Opcode.LD_C_B) => try self.output.print("ld c,b"),
            @enumToInt(opcode.Opcode.LD_C_C) => try self.output.print("ld c,c"),
            @enumToInt(opcode.Opcode.LD_C_D) => try self.output.print("ld c,d"),
            @enumToInt(opcode.Opcode.LD_C_E) => try self.output.print("ld c,e"),
            @enumToInt(opcode.Opcode.LD_C_H) => try self.output.print("ld c,h"),
            @enumToInt(opcode.Opcode.LD_C_L) => try self.output.print("ld c,l"),
            @enumToInt(opcode.Opcode.LD_C_HL) => try self.output.print("ld c,(hl)"),
            @enumToInt(opcode.Opcode.LD_D_B) => try self.output.print("ld d,b"),
            @enumToInt(opcode.Opcode.LD_D_C) => try self.output.print("ld d,c"),
            @enumToInt(opcode.Opcode.LD_D_D) => try self.output.print("ld d,d"),
            @enumToInt(opcode.Opcode.LD_D_E) => try self.output.print("ld d,e"),
            @enumToInt(opcode.Opcode.LD_D_H) => try self.output.print("ld d,h"),
            @enumToInt(opcode.Opcode.LD_D_L) => try self.output.print("ld d,l"),
            @enumToInt(opcode.Opcode.LD_D_HL) => try self.output.print("ld d,(hl)"),
            @enumToInt(opcode.Opcode.LD_E_B) => try self.output.print("ld e,b"),
            @enumToInt(opcode.Opcode.LD_E_C) => try self.output.print("ld e,c"),
            @enumToInt(opcode.Opcode.LD_E_D) => try self.output.print("ld e,d"),
            @enumToInt(opcode.Opcode.LD_E_E) => try self.output.print("ld e,e"),
            @enumToInt(opcode.Opcode.LD_E_H) => try self.output.print("ld e,h"),
            @enumToInt(opcode.Opcode.LD_E_L) => try self.output.print("ld e,l"),
            @enumToInt(opcode.Opcode.LD_E_HL) => try self.output.print("ld e,(hl)"),
            @enumToInt(opcode.Opcode.LD_H_B) => try self.output.print("ld h,b"),
            @enumToInt(opcode.Opcode.LD_H_C) => try self.output.print("ld h,c"),
            @enumToInt(opcode.Opcode.LD_H_D) => try self.output.print("ld h,d"),
            @enumToInt(opcode.Opcode.LD_H_E) => try self.output.print("ld h,e"),
            @enumToInt(opcode.Opcode.LD_H_H) => try self.output.print("ld h,h"),
            @enumToInt(opcode.Opcode.LD_H_L) => try self.output.print("ld h,l"),
            @enumToInt(opcode.Opcode.LD_H_HL) => try self.output.print("ld h,(hl)"),
            @enumToInt(opcode.Opcode.LD_L_B) => try self.output.print("ld l,b"),
            @enumToInt(opcode.Opcode.LD_L_C) => try self.output.print("ld l,c"),
            @enumToInt(opcode.Opcode.LD_L_D) => try self.output.print("ld l,d"),
            @enumToInt(opcode.Opcode.LD_L_E) => try self.output.print("ld l,e"),
            @enumToInt(opcode.Opcode.LD_L_H) => try self.output.print("ld l,h"),
            @enumToInt(opcode.Opcode.LD_L_L) => try self.output.print("ld l,l"),
            @enumToInt(opcode.Opcode.LD_L_HL) => try self.output.print("ld l,(hl)"),
            @enumToInt(opcode.Opcode.LD_HL_B) => try self.output.print("ld (hl),b"),
            @enumToInt(opcode.Opcode.LD_HL_C) => try self.output.print("ld (hl),c"),
            @enumToInt(opcode.Opcode.LD_HL_D) => try self.output.print("ld (hl),d"),
            @enumToInt(opcode.Opcode.LD_HL_E) => try self.output.print("ld (hl),e"),
            @enumToInt(opcode.Opcode.LD_HL_H) => try self.output.print("ld (hl),h"),
            @enumToInt(opcode.Opcode.LD_HL_L) => try self.output.print("ld (hl),l"),
            @enumToInt(opcode.Opcode.LD_HL_n) => try self.output.print("ld (hl),${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_A_BC) => try self.output.print("ld a,(bc)"),
            @enumToInt(opcode.Opcode.LD_A_DE) => try self.output.print("ld a,(de)"),
            @enumToInt(opcode.Opcode.LD_A_nn) => try self.output.print("ld a,(${x})", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.LD_B_A) => try self.output.print("ld b,a"),
            @enumToInt(opcode.Opcode.LD_C_A) => try self.output.print("ld c,a"),
            @enumToInt(opcode.Opcode.LD_D_A) => try self.output.print("ld d,a"),
            @enumToInt(opcode.Opcode.LD_E_A) => try self.output.print("ld e,a"),
            @enumToInt(opcode.Opcode.LD_H_A) => try self.output.print("ld h,a"),
            @enumToInt(opcode.Opcode.LD_L_A) => try self.output.print("ld l,a"),
            @enumToInt(opcode.Opcode.LD_BC_A) => try self.output.print("ld (bc),a"),
            @enumToInt(opcode.Opcode.LD_DE_A) => try self.output.print("ld (de),a"),
            @enumToInt(opcode.Opcode.LD_HL_A) => try self.output.print("ld (hl),a"),
            @enumToInt(opcode.Opcode.LD_nn_A) => try self.output.print("ld (${x}),a", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.LD_A_mem_C) => try self.output.print("ld a,($FF00 + c)"),
            @enumToInt(opcode.Opcode.LD_mem_C_A) => try self.output.print("ld ($FF00 + c),a"),
            @enumToInt(opcode.Opcode.LDD_A_HL) => try self.output.print("ldd a,(hl)"),
            @enumToInt(opcode.Opcode.LDD_HL_A) => try self.output.print("ldd (hl),a"),
            @enumToInt(opcode.Opcode.LDI_A_HL) => try self.output.print("ldi a,(hl)"),
            @enumToInt(opcode.Opcode.LDI_HL_A) => try self.output.print("ldi (hl),a"),
            @enumToInt(opcode.Opcode.LDH_n_A) => try self.output.print("ld ${x},a", u16(0xFF00) | try self.input.readByte()),
            @enumToInt(opcode.Opcode.LDH_A_n) => try self.output.print("ld a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.LD_BC_nn) => try self.output.print("ld bc,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.LD_DE_nn) => try self.output.print("ld de,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.LD_HL_nn) => try self.output.print("ld hl,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.LD_SP_nn) => try self.output.print("ld sp,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.LD_SP_HL) => try self.output.print("ld sp,hl"),
            @enumToInt(opcode.Opcode.LDHL_SP_n) => try self.output.print("ld hl,sp+${x}", try self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.LD_nn_SP) => try self.output.print("ld (${x}),sp", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.PUSH_AF) => try self.output.print("push af"),
            @enumToInt(opcode.Opcode.PUSH_BC) => try self.output.print("push bc"),
            @enumToInt(opcode.Opcode.PUSH_DE) => try self.output.print("push de"),
            @enumToInt(opcode.Opcode.PUSH_HL) => try self.output.print("push hl"),
            @enumToInt(opcode.Opcode.POP_AF) => try self.output.print("pop af"),
            @enumToInt(opcode.Opcode.POP_BC) => try self.output.print("pop bc"),
            @enumToInt(opcode.Opcode.POP_DE) => try self.output.print("pop de"),
            @enumToInt(opcode.Opcode.POP_HL) => try self.output.print("pop hl"),
            @enumToInt(opcode.Opcode.ADD_A_A) => try self.output.print("add a,a"),
            @enumToInt(opcode.Opcode.ADD_A_B) => try self.output.print("add a,b"),
            @enumToInt(opcode.Opcode.ADD_A_C) => try self.output.print("add a,c"),
            @enumToInt(opcode.Opcode.ADD_A_D) => try self.output.print("add a,d"),
            @enumToInt(opcode.Opcode.ADD_A_E) => try self.output.print("add a,e"),
            @enumToInt(opcode.Opcode.ADD_A_H) => try self.output.print("add a,h"),
            @enumToInt(opcode.Opcode.ADD_A_L) => try self.output.print("add a,l"),
            @enumToInt(opcode.Opcode.ADD_A_HL) => try self.output.print("add a,(hl)"),
            @enumToInt(opcode.Opcode.ADD_A_n) => try self.output.print("add a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.ADC_A_A) => try self.output.print("adc a,a"),
            @enumToInt(opcode.Opcode.ADC_A_B) => try self.output.print("adc a,b"),
            @enumToInt(opcode.Opcode.ADC_A_C) => try self.output.print("adc a,c"),
            @enumToInt(opcode.Opcode.ADC_A_D) => try self.output.print("adc a,d"),
            @enumToInt(opcode.Opcode.ADC_A_E) => try self.output.print("adc a,e"),
            @enumToInt(opcode.Opcode.ADC_A_H) => try self.output.print("adc a,h"),
            @enumToInt(opcode.Opcode.ADC_A_L) => try self.output.print("adc a,l"),
            @enumToInt(opcode.Opcode.ADC_A_HL) => try self.output.print("adc a,(hl)"),
            @enumToInt(opcode.Opcode.ADC_A_n) => try self.output.print("adc a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.SUB_A_A) => try self.output.print("sub a,a"),
            @enumToInt(opcode.Opcode.SUB_A_B) => try self.output.print("sub a,b"),
            @enumToInt(opcode.Opcode.SUB_A_C) => try self.output.print("sub a,c"),
            @enumToInt(opcode.Opcode.SUB_A_D) => try self.output.print("sub a,d"),
            @enumToInt(opcode.Opcode.SUB_A_E) => try self.output.print("sub a,e"),
            @enumToInt(opcode.Opcode.SUB_A_H) => try self.output.print("sub a,h"),
            @enumToInt(opcode.Opcode.SUB_A_L) => try self.output.print("sub a,l"),
            @enumToInt(opcode.Opcode.SUB_A_HL) => try self.output.print("sub a,(hl)"),
            @enumToInt(opcode.Opcode.SUB_A_n) => try self.output.print("sub a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.SBC_A_A) => try self.output.print("sbc a,a"),
            @enumToInt(opcode.Opcode.SBC_A_B) => try self.output.print("sbc a,b"),
            @enumToInt(opcode.Opcode.SBC_A_C) => try self.output.print("sbc a,c"),
            @enumToInt(opcode.Opcode.SBC_A_D) => try self.output.print("sbc a,d"),
            @enumToInt(opcode.Opcode.SBC_A_E) => try self.output.print("sbc a,e"),
            @enumToInt(opcode.Opcode.SBC_A_H) => try self.output.print("sbc a,h"),
            @enumToInt(opcode.Opcode.SBC_A_L) => try self.output.print("sbc a,l"),
            @enumToInt(opcode.Opcode.SBC_A_HL) => try self.output.print("sbc a,(hl)"),
            @enumToInt(opcode.Opcode.SBC_A_n) => try self.output.print("sbc a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.AND_A_A) => try self.output.print("and a,a"),
            @enumToInt(opcode.Opcode.AND_A_B) => try self.output.print("and a,b"),
            @enumToInt(opcode.Opcode.AND_A_C) => try self.output.print("and a,c"),
            @enumToInt(opcode.Opcode.AND_A_D) => try self.output.print("and a,d"),
            @enumToInt(opcode.Opcode.AND_A_E) => try self.output.print("and a,e"),
            @enumToInt(opcode.Opcode.AND_A_H) => try self.output.print("and a,h"),
            @enumToInt(opcode.Opcode.AND_A_L) => try self.output.print("and a,l"),
            @enumToInt(opcode.Opcode.AND_A_HL) => try self.output.print("and a,(hl)"),
            @enumToInt(opcode.Opcode.AND_A_n) => try self.output.print("and a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.OR_A_A) => try self.output.print("or a,a"),
            @enumToInt(opcode.Opcode.OR_A_B) => try self.output.print("or a,b"),
            @enumToInt(opcode.Opcode.OR_A_C) => try self.output.print("or a,c"),
            @enumToInt(opcode.Opcode.OR_A_D) => try self.output.print("or a,d"),
            @enumToInt(opcode.Opcode.OR_A_E) => try self.output.print("or a,e"),
            @enumToInt(opcode.Opcode.OR_A_H) => try self.output.print("or a,h"),
            @enumToInt(opcode.Opcode.OR_A_L) => try self.output.print("or a,l"),
            @enumToInt(opcode.Opcode.OR_A_HL) => try self.output.print("or a,(hl)"),
            @enumToInt(opcode.Opcode.OR_A_n) => try self.output.print("or a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.XOR_A_A) => try self.output.print("xor a,a"),
            @enumToInt(opcode.Opcode.XOR_A_B) => try self.output.print("xor a,b"),
            @enumToInt(opcode.Opcode.XOR_A_C) => try self.output.print("xor a,c"),
            @enumToInt(opcode.Opcode.XOR_A_D) => try self.output.print("xor a,d"),
            @enumToInt(opcode.Opcode.XOR_A_E) => try self.output.print("xor a,e"),
            @enumToInt(opcode.Opcode.XOR_A_H) => try self.output.print("xor a,h"),
            @enumToInt(opcode.Opcode.XOR_A_L) => try self.output.print("xor a,l"),
            @enumToInt(opcode.Opcode.XOR_A_HL) => try self.output.print("xor a,(hl)"),
            @enumToInt(opcode.Opcode.XOR_A_n) => try self.output.print("xor a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.CP_A_A) => try self.output.print("cp a,a"),
            @enumToInt(opcode.Opcode.CP_A_B) => try self.output.print("cp a,b"),
            @enumToInt(opcode.Opcode.CP_A_C) => try self.output.print("cp a,c"),
            @enumToInt(opcode.Opcode.CP_A_D) => try self.output.print("cp a,d"),
            @enumToInt(opcode.Opcode.CP_A_E) => try self.output.print("cp a,e"),
            @enumToInt(opcode.Opcode.CP_A_H) => try self.output.print("cp a,h"),
            @enumToInt(opcode.Opcode.CP_A_L) => try self.output.print("cp a,l"),
            @enumToInt(opcode.Opcode.CP_A_HL) => try self.output.print("cp a,(hl)"),
            @enumToInt(opcode.Opcode.CP_A_n) => try self.output.print("cp a,${x}", try self.input.readByte()),
            @enumToInt(opcode.Opcode.INC_A) => try self.output.print("inc a"),
            @enumToInt(opcode.Opcode.INC_B) => try self.output.print("inc b"),
            @enumToInt(opcode.Opcode.INC_C) => try self.output.print("inc c"),
            @enumToInt(opcode.Opcode.INC_D) => try self.output.print("inc d"),
            @enumToInt(opcode.Opcode.INC_E) => try self.output.print("inc e"),
            @enumToInt(opcode.Opcode.INC_H) => try self.output.print("inc h"),
            @enumToInt(opcode.Opcode.INC_L) => try self.output.print("inc l"),
            @enumToInt(opcode.Opcode.INC_mem_HL) => try self.output.print("inc (hl)"),
            @enumToInt(opcode.Opcode.DEC_A) => try self.output.print("dec a"),
            @enumToInt(opcode.Opcode.DEC_B) => try self.output.print("dec b"),
            @enumToInt(opcode.Opcode.DEC_C) => try self.output.print("dec c"),
            @enumToInt(opcode.Opcode.DEC_D) => try self.output.print("dec d"),
            @enumToInt(opcode.Opcode.DEC_E) => try self.output.print("dec e"),
            @enumToInt(opcode.Opcode.DEC_H) => try self.output.print("dec h"),
            @enumToInt(opcode.Opcode.DEC_L) => try self.output.print("dec l"),
            @enumToInt(opcode.Opcode.DEC_mem_HL) => try self.output.print("dec (hl)"),
            @enumToInt(opcode.Opcode.ADD_HL_BC) => try self.output.print("add hl,bc"),
            @enumToInt(opcode.Opcode.ADD_HL_DE) => try self.output.print("add hl,de"),
            @enumToInt(opcode.Opcode.ADD_HL_HL) => try self.output.print("add hl,hl"),
            @enumToInt(opcode.Opcode.ADD_HL_SP) => try self.output.print("add hl,sp"),
            @enumToInt(opcode.Opcode.ADD_SP_n) => try self.output.print("add hl,${x}", self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.INC_BC) => try self.output.print("inc bc"),
            @enumToInt(opcode.Opcode.INC_DE) => try self.output.print("inc de"),
            @enumToInt(opcode.Opcode.INC_HL) => try self.output.print("inc hl"),
            @enumToInt(opcode.Opcode.INC_SP) => try self.output.print("inc sp"),
            @enumToInt(opcode.Opcode.DEC_BC) => try self.output.print("dec bc"),
            @enumToInt(opcode.Opcode.DEC_DE) => try self.output.print("dec de"),
            @enumToInt(opcode.Opcode.DEC_HL) => try self.output.print("dec hl"),
            @enumToInt(opcode.Opcode.DEC_SP) => try self.output.print("dec sp"),
            @enumToInt(opcode.Opcode.DAA) => try self.output.print("daa"),
            @enumToInt(opcode.Opcode.CPL) => try self.output.print("cpl"),
            @enumToInt(opcode.Opcode.CCF) => try self.output.print("ccf"),
            @enumToInt(opcode.Opcode.SCF) => try self.output.print("scf"),
            @enumToInt(opcode.Opcode.HALT) => try self.output.print("halt"),
            @enumToInt(opcode.Opcode.STOP_FIRST_BYTE) => {
                const second_byte = try self.input.readByte();
                if (second_byte != 0) {
                    self.buffer = second_byte;
                    try self.output.print("${x}", @enumToInt(opcode.Opcode.STOP_FIRST_BYTE));
                } else {
                    try self.output.print("stop");
                }
            },
            @enumToInt(opcode.Opcode.DI) => try self.output.print("di"),
            @enumToInt(opcode.Opcode.EI) => try self.output.print("ei"),
            @enumToInt(opcode.Opcode.RLCA) => try self.output.print("rlca"),
            @enumToInt(opcode.Opcode.RLA) => try self.output.print("rla"),
            @enumToInt(opcode.Opcode.RRCA) => try self.output.print("rrca"),
            @enumToInt(opcode.Opcode.RRA) => try self.output.print("rra"),
            @enumToInt(opcode.Opcode.JP_nn) => try self.output.print("jp ${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.JP_NZ_nn) => try self.output.print("jp nz,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.JP_Z_nn) => try self.output.print("jp z,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.JP_NC_nn) => try self.output.print("jp nc,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.JP_C_nn) => try self.output.print("jp c,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.JP_HL) => try self.output.print("jp (HL)"),
            @enumToInt(opcode.Opcode.JR_n) => try self.output.print("jr ${x}", try self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.JR_NZ_n) => try self.output.print("jr nz,${x}", try self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.JR_Z_n) => try self.output.print("jr z,${x}", try self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.JR_NC_n) => try self.output.print("jr nc,${x}", try self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.JR_C_n) => try self.output.print("jr c,${x}", try self.input.readByteSigned()),
            @enumToInt(opcode.Opcode.CALL_nn) => try self.output.print("call ${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.CALL_NZ_nn) => try self.output.print("call nz,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.CALL_Z_nn) => try self.output.print("call z,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.CALL_NC_nn) => try self.output.print("call nc,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.CALL_C_nn) => try self.output.print("call c,${x}", try self.input.readIntLe(u16)),
            @enumToInt(opcode.Opcode.RST_00) => try self.output.print("rst $00"),
            @enumToInt(opcode.Opcode.RST_08) => try self.output.print("rst $08"),
            @enumToInt(opcode.Opcode.RST_10) => try self.output.print("rst $10"),
            @enumToInt(opcode.Opcode.RST_18) => try self.output.print("rst $18"),
            @enumToInt(opcode.Opcode.RST_20) => try self.output.print("rst $20"),
            @enumToInt(opcode.Opcode.RST_28) => try self.output.print("rst $28"),
            @enumToInt(opcode.Opcode.RST_30) => try self.output.print("rst $30"),
            @enumToInt(opcode.Opcode.RST_38) => try self.output.print("rst $38"),
            @enumToInt(opcode.Opcode.RET) => try self.output.print("ret"),
            @enumToInt(opcode.Opcode.RET_NZ) => try self.output.print("ret nz"),
            @enumToInt(opcode.Opcode.RET_Z) => try self.output.print("ret z"),
            @enumToInt(opcode.Opcode.RET_NC) => try self.output.print("ret nc"),
            @enumToInt(opcode.Opcode.RET_C) => try self.output.print("ret c"),
            @enumToInt(opcode.Opcode.RETI) => try self.output.print("reti"),
            @enumToInt(opcode.Opcode.MISC) => {
                const next_byte = try self.input.readByte();
                switch (next_byte) {
                    @enumToInt(opcode.MiscOpcode.SWAP_A) => try self.output.print("swap a"),
                    @enumToInt(opcode.MiscOpcode.SWAP_B) => try self.output.print("swap b"),
                    @enumToInt(opcode.MiscOpcode.SWAP_C) => try self.output.print("swap c"),
                    @enumToInt(opcode.MiscOpcode.SWAP_D) => try self.output.print("swap d"),
                    @enumToInt(opcode.MiscOpcode.SWAP_E) => try self.output.print("swap e"),
                    @enumToInt(opcode.MiscOpcode.SWAP_H) => try self.output.print("swap h"),
                    @enumToInt(opcode.MiscOpcode.SWAP_L) => try self.output.print("swap l"),
                    @enumToInt(opcode.MiscOpcode.SWAP_HL) => try self.output.print("swap (hl)"),
                    @enumToInt(opcode.MiscOpcode.RLC_A) => try self.output.print("rlc a"),
                    @enumToInt(opcode.MiscOpcode.RLC_B) => try self.output.print("rlc b"),
                    @enumToInt(opcode.MiscOpcode.RLC_C) => try self.output.print("rlc c"),
                    @enumToInt(opcode.MiscOpcode.RLC_D) => try self.output.print("rlc d"),
                    @enumToInt(opcode.MiscOpcode.RLC_E) => try self.output.print("rlc e"),
                    @enumToInt(opcode.MiscOpcode.RLC_H) => try self.output.print("rlc h"),
                    @enumToInt(opcode.MiscOpcode.RLC_L) => try self.output.print("rlc l"),
                    @enumToInt(opcode.MiscOpcode.RLC_HL) => try self.output.print("rlc (hl)"),
                    @enumToInt(opcode.MiscOpcode.RL_A) => try self.output.print("rl a"),
                    @enumToInt(opcode.MiscOpcode.RL_B) => try self.output.print("rl b"),
                    @enumToInt(opcode.MiscOpcode.RL_C) => try self.output.print("rl c"),
                    @enumToInt(opcode.MiscOpcode.RL_D) => try self.output.print("rl d"),
                    @enumToInt(opcode.MiscOpcode.RL_E) => try self.output.print("rl e"),
                    @enumToInt(opcode.MiscOpcode.RL_H) => try self.output.print("rl h"),
                    @enumToInt(opcode.MiscOpcode.RL_L) => try self.output.print("rl l"),
                    @enumToInt(opcode.MiscOpcode.RL_HL) => try self.output.print("rl (hl)"),
                    @enumToInt(opcode.MiscOpcode.RRC_A) => try self.output.print("rrc a"),
                    @enumToInt(opcode.MiscOpcode.RRC_B) => try self.output.print("rrc b"),
                    @enumToInt(opcode.MiscOpcode.RRC_C) => try self.output.print("rrc c"),
                    @enumToInt(opcode.MiscOpcode.RRC_D) => try self.output.print("rrc d"),
                    @enumToInt(opcode.MiscOpcode.RRC_E) => try self.output.print("rrc e"),
                    @enumToInt(opcode.MiscOpcode.RRC_H) => try self.output.print("rrc h"),
                    @enumToInt(opcode.MiscOpcode.RRC_L) => try self.output.print("rrc l"),
                    @enumToInt(opcode.MiscOpcode.RRC_HL) => try self.output.print("rrc (hl)"),
                    @enumToInt(opcode.MiscOpcode.RR_A) => try self.output.print("rr a"),
                    @enumToInt(opcode.MiscOpcode.RR_B) => try self.output.print("rr b"),
                    @enumToInt(opcode.MiscOpcode.RR_C) => try self.output.print("rr c"),
                    @enumToInt(opcode.MiscOpcode.RR_D) => try self.output.print("rr d"),
                    @enumToInt(opcode.MiscOpcode.RR_E) => try self.output.print("rr e"),
                    @enumToInt(opcode.MiscOpcode.RR_H) => try self.output.print("rr h"),
                    @enumToInt(opcode.MiscOpcode.RR_L) => try self.output.print("rr l"),
                    @enumToInt(opcode.MiscOpcode.RR_HL) => try self.output.print("rr (hl)"),
                    @enumToInt(opcode.MiscOpcode.SLA_A) => try self.output.print("sla a"),
                    @enumToInt(opcode.MiscOpcode.SLA_B) => try self.output.print("sla b"),
                    @enumToInt(opcode.MiscOpcode.SLA_C) => try self.output.print("sla c"),
                    @enumToInt(opcode.MiscOpcode.SLA_D) => try self.output.print("sla d"),
                    @enumToInt(opcode.MiscOpcode.SLA_E) => try self.output.print("sla e"),
                    @enumToInt(opcode.MiscOpcode.SLA_H) => try self.output.print("sla h"),
                    @enumToInt(opcode.MiscOpcode.SLA_L) => try self.output.print("sla l"),
                    @enumToInt(opcode.MiscOpcode.SLA_HL) => try self.output.print("sla (hl)"),
                    @enumToInt(opcode.MiscOpcode.SRA_A) => try self.output.print("sra a"),
                    @enumToInt(opcode.MiscOpcode.SRA_B) => try self.output.print("sra b"),
                    @enumToInt(opcode.MiscOpcode.SRA_C) => try self.output.print("sra c"),
                    @enumToInt(opcode.MiscOpcode.SRA_D) => try self.output.print("sra d"),
                    @enumToInt(opcode.MiscOpcode.SRA_E) => try self.output.print("sra e"),
                    @enumToInt(opcode.MiscOpcode.SRA_H) => try self.output.print("sra h"),
                    @enumToInt(opcode.MiscOpcode.SRA_L) => try self.output.print("sra l"),
                    @enumToInt(opcode.MiscOpcode.SRA_HL) => try self.output.print("sra (hl)"),
                    @enumToInt(opcode.MiscOpcode.SRL_A) => try self.output.print("srl a"),
                    @enumToInt(opcode.MiscOpcode.SRL_B) => try self.output.print("srl b"),
                    @enumToInt(opcode.MiscOpcode.SRL_C) => try self.output.print("srl c"),
                    @enumToInt(opcode.MiscOpcode.SRL_D) => try self.output.print("srl d"),
                    @enumToInt(opcode.MiscOpcode.SRL_E) => try self.output.print("srl e"),
                    @enumToInt(opcode.MiscOpcode.SRL_H) => try self.output.print("srl h"),
                    @enumToInt(opcode.MiscOpcode.SRL_L) => try self.output.print("srl l"),
                    @enumToInt(opcode.MiscOpcode.SRL_HL) => try self.output.print("srl (hl)"),
                    @enumToInt(opcode.MiscOpcode.BIT_A) => try self.output.print("bit ${x},a", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_B) => try self.output.print("bit ${x},b", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_C) => try self.output.print("bit ${x},c", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_D) => try self.output.print("bit ${x},d", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_E) => try self.output.print("bit ${x},e", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_H) => try self.output.print("bit ${x},h", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_L) => try self.output.print("bit ${x},l", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.BIT_HL) => try self.output.print("bit ${x},(hl)", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_A) => try self.output.print("set ${x},a", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_B) => try self.output.print("set ${x},b", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_C) => try self.output.print("set ${x},c", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_D) => try self.output.print("set ${x},d", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_E) => try self.output.print("set ${x},e", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_H) => try self.output.print("set ${x},h", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_L) => try self.output.print("set ${x},l", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.SET_HL) => try self.output.print("set ${x},(hl)", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_A) => try self.output.print("res ${x},a", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_B) => try self.output.print("res ${x},b", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_C) => try self.output.print("res ${x},c", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_D) => try self.output.print("res ${x},d", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_E) => try self.output.print("res ${x},e", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_H) => try self.output.print("res ${x},h", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_L) => try self.output.print("res ${x},l", try self.input.readByte()),
                    @enumToInt(opcode.MiscOpcode.RES_HL) => try self.output.print("res ${x},(hl)", try self.input.readByte()),
                    else => try self.output.print("${x}", next_byte),
                }
            },
            else => try self.output.print("${x}", byte),
        }
    }
};

test "Disassembler" {
    var test_rom_file = try std.os.File.openRead(std.debug.global_allocator, "testdata/sprite_priority.gb");
    defer test_rom_file.close();
    var stdout = try std.io.getStdOut();
    var inStream = std.io.FileInStream.init(&test_rom_file);
    var outStream = std.io.FileOutStream.init(&stdout);
    var disassembler = Disassembler.init(&inStream.stream, &outStream.stream);
    var i: i32 = 0;
    while (i < 500) : (i += 1) {
        try disassembler.disassemble();
        try outStream.stream.write("\n");
    }
}
