function ll
  if type -q exa
	  command exa -l $argv
  else
	  command ls -ltr $argv
  end
end
