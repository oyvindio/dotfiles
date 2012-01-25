unless 'macruby' == RUBY_ENGINE
  require 'irb/ext/save-history'
  ARGV.concat [ "--readline"]
end
