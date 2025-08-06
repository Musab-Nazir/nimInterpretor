import os

when isMainModule:
  # import the code from the input file
  let code = if paramCount() > 0: readFile paramStr(1)
             else: readAll stdin

  # echo code

  var
    tape = newSeq[char]()
    tapePos = 0
    codePos = 0

  {.push overflowchecks: off.}
  proc xinc*(c: var char) {.inline.} =
    ## Increment a character with wrapping instead of overflow checks.
    inc c
  proc xdec*(c: var char) {.inline.} =
    ## Decrement a character with wrapping instead of underflow checks.
    dec c
  {.pop.}

  proc run(skip = false): bool =
    while tapePos >= 0 and codePos < code.len:
      if tapePos >= tape.len:
        tape.add '\0'

      if code[codePos] == '[':
        inc codePos
        let oldPos = codePos
        while run(tape[tapePos] == '\0'):
          codePos = oldPos
      elif code[codePos] == ']':
        return tape[tapePos] != '\0'
      elif not skip:
        case code[codePos]
        of '+': xinc tape[tapePos]
        of '-': xdec tape[tapePos]
        of '>': inc tapePos
        of '<': dec tapePos
        of '.': stdout.write tape[tapePos]
        of ',': tape[tapePos] = stdin.readChar
        else: discard

      inc codePos

  discard run()
