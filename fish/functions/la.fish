function la
  if type -q exa
	  command exa -la $argv
  else
      command ls -A -l -G $argv
  end
end
