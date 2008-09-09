class VimJolts
  Version = '0.0.1'
end

class VimJolts::Command
  def self.help(command)
    hash = {
      'install' => <<-EOF
Usage: jolt install JOLTNAME
Arguments:
  JOLTNAME       name of jolt to install
Summary:
  Install a vimscript package into the local repository
      EOF
    }
    if hash[command]
      puts hash[command]
    else
      puts "'help #{command}' not found"
    end
  end

  def self.help_default
    puts <<-HELP

  VimJolts is a sophisticated package manager for Vim.  This is a
  basic help message containing pointers to more information.

    Usage:
      jolt -h/--help
      jolt -v/--version
      jolt command [arguments...] [options...]

    Examples:
      jolt install rake
      jolt list --local
      jolt build package.gemspec

    Further information:
      http://vimjolts.org
    HELP
  end

  def self.version
    puts "VimJolts VimJolts::VimJolts"
  end

  def self.install(package, *options)
    p package
    p options
  end
end
