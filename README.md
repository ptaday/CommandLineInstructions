# MIPS Assembly Language Assignment README

This repository contains the implementation of various MIPS assembly language operations for computing and data manipulation. The assignment is divided into multiple parts, each requiring you to implement specific functionality. The goal is to validate command-line arguments, process input, and perform computations based on the given requirements.

## Table of Contents

- [Part 1: Validate Command-line Arguments](#part-1-validate-command-line-arguments)
- [Part 2: Encode a MIPS I-type Instruction](#part-2-encode-a-mips-i-type-instruction)
- [Part 3: Decode a MIPS I-type Instruction](#part-3-decode-a-mips-i-type-instruction)
- [Part 4: Identify the Poker Hand](#part-4-identify-the-poker-hand)
- [Usage and Execution](#usage-and-execution)
- [Notes](#notes)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Part 1: Validate Command-line Arguments

In this part, your task is to validate the first command-line argument and the number of command-line arguments. The program will perform the following checks:

1. Check for a valid operation character: E, D, or P. Print an error message and exit if invalid.
2. Validate the number of additional arguments based on the operation:
   - E operation: Four additional arguments required.
   - D operation: One additional argument required.
   - P operation: One additional argument required.

## Part 2: Encode a MIPS I-type Instruction

In this part, you will implement the encoding of a MIPS I-type instruction. The program will take four decimal values as command-line arguments and combine them into a 32-bit integer representing an I-type instruction. The output will be printed in hexadecimal format.

## Part 3: Decode a MIPS I-type Instruction

Here, you will decode a given 8-digit hexadecimal value representing an I-type instruction. The program will extract and print the opcode, rs, rt, and immediate fields in decimal format.

## Part 4: Identify the Poker Hand

For this part, the program will identify a non-standard five-card poker hand represented by command-line arguments. The input will be a string of five characters, each representing a card. The program will determine the hand's rank and print the result.

## Usage and Execution

1. Clone this repository to your local machine.
2. Navigate to the repository's directory: `cd mips-assignment`.
3. Assemble the MIPS assembly file using your preferred MIPS assembler.
4. Execute the program with appropriate command-line arguments.

## Notes

- Ensure that the provided labels and strings for error messages are used exactly as specified in the assignment. Incorrect labels or strings may result in grading penalties.
- Additional input validation and error handling may be required based on specific operation requirements.

For detailed implementation and code, refer to the relevant sections in the source code (e.g., `hw8.asm`).

## Contributing

Contributions to this project are welcome. If you find any issues or improvements, please submit a pull request. Follow the provided guidelines for contributing and ensure that your code adheres to the coding standards.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries or feedback, please contact:
- Pushkar Taday
- Email: pmtaday@gmail.com
- GitHub: ptaday



