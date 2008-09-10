require 'open-uri'
require 'rubygems'
require 'hpricot'

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
      jolt help install
      jolt install metarw
      jolt list --local

    Further information:
      http://vimjolts.org
    HELP
  end

  def self.version
    puts "VimJolts #{VimJolts::Version}"
  end

  def self.install(package, *options)
    # mock
    if package != 'metarw'
      puts 'install not supported except "install metarw"'
      exit
    end

    # metarw only

    # check installed or not
    if File.exist?(File.expand_path('~/.vim/jolts/metarw-0.0.3/'))
      puts "metarw already installed."
      exit
    end

    # fetch
    vshash = VimJolts::Utility.fetch_recent('2335')
    p vshash
  end
end

class VimJolts::Utility
  def self.fetch_recent(script_id)
    fname = "/tmp/jolt#{rand}.zip"
    h = Hpricot(open("http://www.vim.org/scripts/script.php?script_id=#{script_id}"))
    script_link = h.at("a[@href^='download_script']")
    fname = script_link.inner_html
    {
      :filename => fname,
      :packagename => fname[/[^\.]*/][0..-3],
      :version => fname[/\d\.\d\.\d/],
      :ext => fname[/\w*$/],
      :uri => "http://www.vim.org/scripts/" + script_link[:href]
    }
  end
end
