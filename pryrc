if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'sm', 'show-method'
  Pry.commands.alias_command 'bt', 'pry-backtrace'
  Pry.commands.alias_command 'w', 'whereami'
end
