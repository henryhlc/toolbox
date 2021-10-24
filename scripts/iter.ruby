#!/usr/local/bin/ruby

# Iteratively build shell commands from a template
# Given a template such as 'ls {}' this command will repeatedly
# ask for

# Usage: ruby iter.ruby [template]
#   - template: a string with '{}' denoting places to be replaced.

require 'readline'

template = ARGV.join(' ')
while true do
  line = Readline.readline("> ", true)
  system(template.gsub(/{}/, line))
end

