# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

when isMainModule:
  var x = 0
  for i in 1 .. 100_000_000:
    x += 1

  echo("Hello, World! ", x)
