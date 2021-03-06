package simmac;

public class Instruction {

//integer values of mico-instructions.
	public static final int DW = 0x0000;

	public static final int ADD = 0x0001;

	public static final int SUB = 0x0002;

	public static final int LDA = 0x0003;

	public static final int LDI = 0x0004;

	public static final int STR = 0x0005;

	public static final int BRH = 0x0006;

	public static final int CBR = 0x0007;

	public static final int HLT = 0x0008;

//Validates that program input is valid opcode and returns its integer value opcode if so.

	public static int getOpcode(String word) {

		String opcode = word.toUpperCase();

		switch (opcode) {

		case "DW":

			return DW;

		case "ADD":

			return ADD;

		case "SUB":

			return SUB;

		case "LDA":

			return LDA;

		case "LDI":

			return LDI;

		case "STR":

			return STR;

		case "BRH":

			return BRH;

		case "CBR":

			return CBR;

		case "HLT":

			return HLT;

		default:

			return -1;

		}

	}

// If operand is valid then returens integer value if not then null
	private static Integer parseOperand(int opcode, String operand, String filename, int nline) {

		switch (opcode) {

		case ADD:

		case SUB:

		case LDA:

		case STR:

		case BRH:

		case CBR:

// if valid unsigned number
			if (operand.matches("\\d+")) {

				int val = Integer.parseInt(operand);

//If at most 16 bits.
				if (val >= 0 && val < 32767)

					return val;

				else {

					System.out.println("Something went wrong. " + filename + " " + nline + " then number: " + operand
							+ " is longer than 16 bits.");

					return null;

				}

			}

			else {
				System.out.println("Something went wrong. " + filename + " " + nline + " invalid number: " + operand + ".");

				return null;

			}

		case DW:

			if (operand.matches("[+-]?\\d+")) {

				int val = Integer.parseInt(operand);

				return val;

			}

			else {
				System.out.println("Something went wrong. " + filename + " " + nline + " invalid number: " + operand + ".");

				return null;

			}

		case LDI:

			if (operand.matches("[+-]?\\d+")) {

				int val = Integer.parseInt(operand);
//If at most 16 bits.
				if (val >= -32768 && val < 32767)

					return val;

				else {
					System.out
							.println("+filename+" + "+nline+" + " the number: " + operand + " is longer than 16 bits.");

					return null;

				}

			}

			else {

				System.out.println(filename + " " + nline + " invalid number: " + operand + ".");
				return null;

			}

		default:

			return null;

		}

	}

//Validates to see if line given corresponds to a valid instruction.
	public static Integer parseInstruction(String line, String filename, int nline) {

		String[] parts = line.split("\\s+");
		if (parts.length > 2) {

			System.out.println("Something went wrong. [" + filename + "(" + nline
					+ ")]:  A SIMMAC instruction can only contain one opcode and one operand.");

			return null;

		}

		if (parts[0].length() == 0) {

			System.out.println("Something went wrong. [" + filename + "(" + nline
					+ ")]:  A SIMMAC instruction can only contain one opcode and one operand.");

			return null;

		}

		int opc = getOpcode(parts[0]);

		if (opc == -1) {

			System.out
					.println("Something went wrong.  [" + filename + "(" + nline + ")]: invalid instruction opcode: " + parts[0] + ".");

			return null;

		}

		if (opc == HLT) {

//Halt cant have more then one instruction.
			if (parts.length > 1) {

				System.out.println("Something went wrong.  HLT does not need operand.");

				return null;

			}

			return (opc << 16);

		}

		else {

			if (parts.length != 2) {

				System.out.println(
						"Something went wrong. " + filename + " " + nline + " Must containt opcode and operand unless using HLT.");

				return null;

			}

			Integer op = parseOperand(opc, parts[1], filename, nline);

			if (op == null)

				return null;

			return ((opc << 16) | op);

		}

	}

}