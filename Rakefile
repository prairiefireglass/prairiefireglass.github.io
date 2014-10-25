# encoding: utf-8

require "json"

url_pow     = "pfg"
url_live    = "prairiefireglass.com"
github_repo = "pfg/pfg.github.com"

desc "Delete old website files to start fresh."
task :clean do
  puts "Starting fresh!"
  system "rm -rf public"
end

desc "Design, write, and edit live."
task :default do
  system "jekyll build -w"
end

desc "Build a clean, compressed copy of the site."
task :build do
  system "jekyll build"
  puts "Done! See it locally at http://#{url_pow}.dev, or live at http://#{url_live}."
end

desc "Builds a fresh copy of your site, then opens it."
task :view => [:build] do
  system "open http://#{url_pow}.dev"
end

namespace :view do
  desc "View your site live."
  task :live do
    system "open http://#{url_live}"
  end

  desc "Generate an xip.io friendly URL."
  task :xip do
    ip = `ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | awk '{ printf "%s", $0 }'`
    url = "http://#{url_pow}.#{ip}.xip.io/"
    puts "Opening #{url}…"
    system "open #{url}"
  end

  desc "View your project on GitHub."
  task :github do
    system "open http://github.com/#{github_repo}"
  end
end
